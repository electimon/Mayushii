#import "OFArray+Mayushii.h"

@implementation OFArray (Mayushii)

- (BOOL)anyObjectPassingTest:(bool (^)(id object))block {
    for (id object in self) {
        BOOL ret = block(object);
        if (ret == YES)
            return ret;
    }
    return NO;
}

@end