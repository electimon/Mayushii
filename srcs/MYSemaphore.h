#import <ObjFW/ObjFW.h>

@interface MYSemaphore: OFObject
+ (instancetype)semaphore:(int)initialValue;
- (BOOL)wait;
- (BOOL)signal;
@end