#import "OFIRI+Mayushii.h"

@implementation OFIRI (Mayushii)

- (OFIRI *)IRIByReplacingPathExtension:(OFString *)replacement {
	return [[self IRIByDeletingPathExtension] IRIByAppendingPathExtension:replacement];
}

@end
