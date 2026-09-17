#import <ObjFW/ObjFW.h>

@interface MYArgExceptionDuplicateFlag : OFException
@end

@interface MYArgExceptionOptionNotFound : OFException
@end

@interface MYArgExceptionUnsupportedValueType : OFException
@end

@interface MYArgExceptionCannotConvertValue : OFException
@end

@interface MYArgMatch : OFObject
@property (nonatomic, strong) OFString *_Nonnull flag;
@property (nonatomic, strong) _Nonnull id value;

- (_Nonnull instancetype)initWithFlag:(OFString *_Nonnull)flag andValue:(_Nonnull id)value;
@end

@interface MYArgOption : OFObject
@property (nonatomic, strong) OFString *_Nonnull longForm;
@property (nonatomic, strong) OFString *_Nullable shortForm;
@property (nonatomic) Class _Nullable valueType;
@property (nonatomic, strong) id _Nullable implicitValue;

- (_Nonnull instancetype)initWithLongForm:(OFString *_Nonnull)longForm shortForm:(OFString *_Nullable)shortForm valueType:(_Nullable Class)valueType withImplictValue:(_Nullable id)implictValue;
+ (_Nonnull instancetype)optionWithLongForm:(OFString *_Nonnull)longForm shortForm:(OFString *_Nonnull)shortForm valueType:(_Nonnull Class)valueType withImplictValue:(_Nonnull id)implictValue;
+ (_Nonnull instancetype)optionWithLongForm:(OFString *_Nonnull)longForm valueType:(_Nonnull Class)valueType withImplictValue:(_Nonnull id)implictValue;
+ (_Nonnull instancetype)optionWithLongForm:(OFString *_Nonnull)longForm andShortForm:(OFString *_Nonnull)shortForm;
+ (_Nonnull instancetype)optionWithLongForm:(OFString *_Nonnull)longForm;
@end