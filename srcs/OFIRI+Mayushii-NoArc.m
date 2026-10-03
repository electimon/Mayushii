#import "OFIRI+Mayushii-NoArc.h"

@implementation OFIRI (MayushiiNonArc)

- (void)deleteFirstPathComponent {
	void *pool = objc_autoreleasePoolPush();
	OFString *path = _percentEncodedPath;

	// case = / || case = ""
	if (path.length == 0 || [path isEqual: @"/"]) {
		objc_autoreleasePoolPop(pool);
		return;
	}

	OFRange firstRange = [path rangeOfString: @"/"];
	if (firstRange.location == OFNotFound) {
		objc_autoreleasePoolPop(pool);
		return;
	}
	
	OFRange secondRange = [path rangeOfString: @"/" options:0 range:OFMakeRange(firstRange.location+1, path.length-1)];
	size_t secondPos = secondRange.location;
	if (secondPos == OFNotFound) {
		objc_release(_percentEncodedPath);
		_percentEncodedPath = objc_retain(@"/");

		objc_autoreleasePoolPop(pool);
		return;
	}

	path = [path substringFromIndex: secondRange.location];
	objc_release(_percentEncodedPath);
	_percentEncodedPath = objc_retain(path);

	objc_autoreleasePoolPop(pool);
}

- (OFIRI *)IRIByDeletingFirstPathComponent {
	OFMutableIRI *IRI = objc_autorelease([self mutableCopy]);
	[IRI deleteFirstPathComponent];
	[IRI makeImmutable];
	return IRI;
}

@end