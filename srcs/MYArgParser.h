#import <ObjFW/ObjFW.h>

@interface MYArgOption : OFObject
@property (nonatomic, strong) OFString *longForm;
@property (nonatomic, strong) OFString *shortForm;
@property (nonatomic) Class valueType;
@property (nonatomic, strong) id implicitValue;
@end

@interface MYArgMatch : OFObject
@property (nonatomic, strong) OFString *flag;
@property (nonatomic, strong) id value;
@end

@interface MYArgParser : OFObject

+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options enableStdinParsing:(BOOL)enableStdinParsing;

@end