#import <ObjFW/ObjFW.h>

@interface MYArgOption : OFObject
@property (nonatomic, strong) OFString *longForm;
@property (nonatomic, strong) OFString *_Nullable shortForm;
@property (nonatomic) Class _Nullable valueType;
@property (nonatomic, strong) id _Nullable implicitValue;

- (instancetype)initWithLongForm:(OFString *)longForm shortForm:(OFString *_Nullable)shortForm valueType:(_Nullable Class)valueType withImplictValue:(_Nullable id)implictValue;
+ (instancetype)optionWithLongForm:(OFString *)longForm shortForm:(OFString *_Nullable)shortForm valueType:(Class)valueType withImplictValue:(id)implictValue;
+ (instancetype)optionWithLongForm:(OFString *)longForm valueType:(Class)valueType withImplictValue:(id)implictValue;
+ (instancetype)optionWithLongForm:(OFString *)longForm andShortForm:(OFString *_Nullable)shortForm;
+ (instancetype)optionWithLongForm:(OFString *)longForm;
@end

@interface MYArgMatch : OFObject
@property (nonatomic, strong) OFString *flag;
@property (nonatomic, strong) id value;

- (instancetype)initWithFlag:(OFString *)flag andValue:(_Nullable id)value;

@end

@interface MYArgExceptionOptionNotFound : OFException
@end

@interface MYArgExceptionCannotConvertValue : OFException
@end

@interface MYArgParser : OFObject

- (instancetype)initWithOptions:(OFArray<MYArgOption *> *)options enableEndOfOptions:(BOOL)enableEndOfOptions;
+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options enableEndOfOptions:(BOOL)enableEndOfOptions;
+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options;

- (OFArray<MYArgMatch *> *)getMatches:(OFArray *)arguments;

@end