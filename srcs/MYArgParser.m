#import "MYArgParser.h"

// RGL-001 Argumentative Monster

// yes we abuse isEqual, get over it

@implementation MYArgMatch

- (instancetype)initWithFlag:(OFString *)flag andValue:(id)value {
	self = [super init];
	self.flag = flag;
	self.value = value;
	return self;
}

- (OFString *)description {
	return [OFString stringWithFormat:@"%@: flag: %@, value: %@", [self class], self.flag, self.value];
}

- (BOOL)isEqual:(id)object {
	return [self.flag isEqual:object];
}

@end

@implementation MYArgOption

- (OFString *)normalizeLongFormIfNeeded:(OFString *)longForm {
	if ([longForm hasPrefix:@"--"])
		return longForm;
	return [@"--" stringByAppendingString:longForm];

}

- (OFString *)normalizeShortFormIfNeeded:(OFString *_Nullable)shortForm {
	if (shortForm == nil)
		return nil;
	if ([shortForm hasPrefix:@"-"])
		return shortForm;
	return [@"-" stringByAppendingString:shortForm];

}

- (instancetype)initWithLongForm:(OFString *)longForm shortForm:(OFString *_Nullable)shortForm valueType:(Class)valueType withImplictValue:(id)implictValue {
	self = [super init];
	self.longForm = [self normalizeLongFormIfNeeded:longForm];
	self.shortForm = [self normalizeShortFormIfNeeded:shortForm];
	self.valueType = valueType;
	self.implicitValue = implictValue;
	return self;
}

+ (instancetype)optionWithLongForm:(OFString *)longForm shortForm:(OFString *)shortForm valueType:(Class)valueType withImplictValue:(id)implictValue {
	return [[MYArgOption alloc] initWithLongForm:longForm shortForm:shortForm valueType:valueType withImplictValue:implictValue];
}

+ (instancetype)optionWithLongForm:(OFString *)longForm valueType:(Class)valueType withImplictValue:(id)implictValue {
	return [[MYArgOption alloc] initWithLongForm:longForm shortForm:nil valueType:valueType withImplictValue:implictValue];
}

+ (instancetype)optionWithLongForm:(OFString *)longForm andShortForm:(OFString *)shortForm {
	return [[MYArgOption alloc] initWithLongForm:longForm shortForm:shortForm valueType:nil withImplictValue:nil];
}

+ (instancetype)optionWithLongForm:(OFString *)longForm {
	return [[MYArgOption alloc] initWithLongForm:longForm shortForm:nil valueType:nil withImplictValue:nil];
}

- (OFString *)description {
	return [OFString stringWithFormat:@"%@: longForm: %@, shortForm: %@, valueType: %@, implictValue: %@", [self class], self.longForm, self.shortForm, self.valueType, self.implicitValue];
}

- (BOOL)isEqual:(id)object {
	return [self.longForm isEqual:object] || [self.shortForm isEqual:object];
}

- (unsigned long)hash {
	return [self.longForm hash];
}

@end

@interface MYArgExceptionDuplicateFlag ()
@property (nonatomic, retain) OFString *duplicateFlag;

+ (instancetype)exceptionWithDuplicateFlag:(OFString *)duplicateFlag;
@end

@implementation MYArgExceptionDuplicateFlag

+ (instancetype)exceptionWithDuplicateFlag:(OFString *)duplicateFlag {
	MYArgExceptionDuplicateFlag *ex = [[MYArgExceptionDuplicateFlag alloc] init];
	ex.duplicateFlag = duplicateFlag;
	return ex;
}

- (OFString *)description {
	return [OFString stringWithFormat:@"MYArgParser encountered a duplicate flag (%@)!", self.duplicateFlag];
}

@end

@interface MYArgExceptionOptionNotFound ()
@property (nonatomic, retain) OFString *encounteredFlag;

+ (instancetype)exceptionWithEncounteredFlag:(OFString *)encounteredFlag;
@end

@implementation MYArgExceptionOptionNotFound

+ (instancetype)exceptionWithEncounteredFlag:(OFString *)encounteredFlag {
	MYArgExceptionOptionNotFound *ex = [[MYArgExceptionOptionNotFound alloc] init];
	ex.encounteredFlag = encounteredFlag;
	return ex;
}

- (OFString *)description {
	return [OFString stringWithFormat:@"MYArgParser encountered a flag (%@) it doesn't recognize", self.encounteredFlag];
}

@end

@interface MYArgExceptionUnsupportedValueType ()
@property (nonatomic, retain) Class requestedType;

+ (instancetype)exceptionWithRequestedType:(Class)requestedType;
@end

@implementation MYArgExceptionUnsupportedValueType

+ (instancetype)exceptionWithRequestedType:(Class)requestedType {
	MYArgExceptionUnsupportedValueType *ex = [[MYArgExceptionUnsupportedValueType alloc] init];
	ex.requestedType = requestedType;
	return ex;
}

- (OFString *)description {
	return [OFString stringWithFormat:@"MYArgParser encountered requested value type of %@ which it does not know how to convert!", self.requestedType];
}

@end

@interface MYArgExceptionCannotConvertValue ()
@property (nonatomic, retain) Class requestedType;
@property (nonatomic, retain) OFString *foundValue;

+ (instancetype)exceptionWithRequestedType:(Class)requestedType andFoundValue:(OFString *)foundValue;
@end

@implementation MYArgExceptionCannotConvertValue

+ (instancetype)exceptionWithRequestedType:(Class)requestedType andFoundValue:(OFString *)foundValue {
	MYArgExceptionCannotConvertValue *ex = [[MYArgExceptionCannotConvertValue alloc] init];
	ex.requestedType = requestedType;
	ex.foundValue = foundValue;
	return ex;
}

- (OFString *)description {
	return [OFString stringWithFormat:@"MYArgParser tried to honor your request to return a value of type %@ however we got '%@' which we could not convert", self.requestedType, self.foundValue];
}

@end

@interface MYArgParser ()
@property (nonatomic, retain) OFArray *loadedOptions;
@property (nonatomic) BOOL enableEndOfOptions;
@end

@implementation MYArgParser

- (instancetype)initWithOptions:(OFArray<MYArgOption *> *)options enableEndOfOptions:(BOOL)enableEndOfOptions {
	self = [super init];
	self.loadedOptions = [options copy];
	self.enableEndOfOptions = enableEndOfOptions;
	return self;
}

+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options enableEndOfOptions:(BOOL)enableEndOfOptions {
	return [[MYArgParser alloc] initWithOptions:options enableEndOfOptions:enableEndOfOptions];
}

+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options {
	return [[MYArgParser alloc] initWithOptions:options enableEndOfOptions:YES];
}

- (OFArray<MYArgMatch *> *)getMatches:(OFArray *)arguments {
	if (arguments.count <= 0)
		return @[];

	OFMutableArray *matches = [[OFMutableArray alloc] init];

	for (int i = 0; i < arguments.count; i++) {
		OFString *maybeFlag = [arguments objectAtIndex:i];

		// early exit because unrecognized option passed
		if (![self.loadedOptions containsObject:maybeFlag])
			@throw ([MYArgExceptionOptionNotFound exceptionWithEncounteredFlag:maybeFlag]);

		MYArgOption *option = [self.loadedOptions objectAtIndex:[self.loadedOptions indexOfObject:maybeFlag]];

		// we continue when we have passed this flag already
		if ([matches containsObject:option.longForm])
			@throw ([MYArgExceptionDuplicateFlag exceptionWithDuplicateFlag:maybeFlag]);

		id value = nil;
		if (option.valueType != nil) {
			if (![option.valueType isEqual:[OFNumber class]] && ![option.valueType isEqual:[OFString class]])
				@throw ([MYArgExceptionUnsupportedValueType exceptionWithRequestedType:option.valueType]);

			if (i == arguments.count-1) {
				[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:option.implicitValue]];
				continue;
			}

			OFString *maybeValue = [arguments objectAtIndex:i+1];
			if (self.enableEndOfOptions && [maybeValue isEqual:@"--"]) {
				if (i+2 == arguments.count) {
					// we've reached the end of the list and the user didn't pass anything after the '--'
					if ([option.valueType isEqual:[OFNumber class]])
						[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:[OFNumber numberWithInt:0]]];
					else if ([option.valueType isEqual:[OFString class]])
						[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:@""]];
					// insert more cases here
					return matches;
				}
				value = [[arguments objectsInRange:OFMakeRange(i+2, arguments.count-(i+2))] componentsJoinedByString:@" "];
				if ([option.valueType isEqual:[OFNumber class]])
					@try {
						[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:[OFNumber numberWithInt:[value intValue]]]];
					} @catch (OFInvalidFormatException *ex) {
						@throw ([MYArgExceptionCannotConvertValue exceptionWithRequestedType:option.valueType andFoundValue:value]);
					}
				else
					[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:value]];
				return matches;
			} else if (([maybeValue hasPrefix:@"-"] && maybeValue.length > 1) && (([option.valueType isEqual:[OFString class]]) || ([option.valueType isEqual:[OFNumber class]] && !isdigit([maybeValue characterAtIndex:1])))) {
				[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:option.implicitValue]];
				continue;
			}

			if ([option.valueType isEqual:[OFNumber class]])
				@try {
					value = [OFNumber numberWithInt:[maybeValue intValue]];
				} @catch (OFException *ex) {
					@throw ([MYArgExceptionCannotConvertValue exceptionWithRequestedType:option.valueType andFoundValue:maybeValue]);
				}
			else if ([option.valueType isEqual:[OFString class]])
				value = maybeValue;

			i++; // we ate the value after this current idx... yummy...

			[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:value]];
		} else
			[matches addObject:[[MYArgMatch alloc] initWithFlag:option.longForm andValue:[OFNumber numberWithBool:YES]]];
	}
	return matches;
}
@end	