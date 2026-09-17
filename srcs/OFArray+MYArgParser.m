#import "OFArray+MYArgParser.h"
#import "MYArgParser-Classes.h"

@implementation OFArray (MYArgParser)

- (size_t)indexOfFlag:(OFString *)flag {
    for (size_t i = 0; i < self.count; i++) {
        MYArgOption *option = self[i];
        if (option == nil || ![option isKindOfClass:[MYArgOption class]])
            continue;
        if ([option.longForm isEqual:flag] || [option.shortForm isEqual:flag])
            return i;
    }
    return OFNotFound;
}

- (size_t)indexOfMatch:(OFString *)flag {
    for (size_t i = 0; i < self.count; i++) {
        MYArgMatch *match = self[i];
        if (match == nil || ![match isKindOfClass:[MYArgMatch class]])
            continue;
        if ([match.flag isEqual:flag])
            return i;
    }
    return OFNotFound;
}

-  (BOOL)containsFlag:(OFString *)flag {
    return [self indexOfFlag:flag] != OFNotFound;
}

-  (BOOL)containsMatch:(OFString *)flag {
    return [self indexOfMatch:flag] != OFNotFound;
}

@end