#import "OFString+Mayushii.h"

@implementation OFString (Mayushii)

- (OFString *)stringByReplacingPathExtension:(OFString *)replacement {
	return [[self stringByDeletingPathExtension] stringByAppendingPathExtension:replacement];
}

@end
