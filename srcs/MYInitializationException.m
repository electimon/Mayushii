#import "MYInitializationException.h"

@implementation MYInitializationException

+ (instancetype)exceptionWithDescription:(OFString *)exceptionDescription {
	MYInitializationException *ex = [[MYInitializationException alloc] init];
	ex.exceptionDescription = exceptionDescription;
	return ex;
}

- (OFString *)description {
	return _exceptionDescription;
}

@end