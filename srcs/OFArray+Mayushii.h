#import <ObjFW/ObjFW.h>

@interface OFArray (Mayushii)
- (BOOL)anyObjectPassingTest:(bool (^)(id object))block;
@end