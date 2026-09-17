#import <ObjFW/ObjFW.h>

@interface OFArray (MYArgParser)
- (size_t)indexOfFlag:(OFString *)flag;
- (BOOL)containsFlag:(OFString *)flag;
- (size_t)indexOfMatch:(OFString *)flag;
- (BOOL)containsMatch:(OFString *)flag;
@end