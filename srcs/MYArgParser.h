#import <ObjFW/ObjFW.h>
#import "MYArgParser-Classes.h"

@interface MYArgParser : OFObject

- (_Nonnull instancetype)initWithOptions:(OFArray<MYArgOption *> *_Nonnull)options enableEndOfOptions:(BOOL)enableEndOfOptions;
+ (_Nonnull instancetype)parserWithOptions:(OFArray<MYArgOption *> *_Nonnull)options enableEndOfOptions:(BOOL)enableEndOfOptions;
+ (_Nonnull instancetype)parserWithOptions:(OFArray<MYArgOption *> *_Nonnull)options;

- (OFArray<MYArgMatch *> *_Nonnull)getMatches:(OFArray *_Nonnull)arguments;

@end