#import <ObjFW/ObjFW.h>

typedef void (^MYScheduledOperationOperation)(void);

@interface MYScheduledOperation : OFObject
+ (instancetype)schedule:(double)interval operation:(__strong MYScheduledOperationOperation)block;
@end