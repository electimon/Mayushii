#import "MYMimeParser.h"
#import "MYDataManager.h"

// RGL-006 Mime Emporium

@implementation MYMimeParser

static bool initOk = false;
// im the memory monsta!
static OFMutableDictionary *mimeDB;

+ (void)loadMimeDB {
	OFFile *mimeFile = [OFFile fileWithPath:[[MYDataManager getDataFileIRI:@"mime.types"] fileSystemRepresentation] mode:@"r"];
	OFString *line;
	mimeDB = [[OFMutableDictionary alloc] init];
	while ((line = [mimeFile readLine]) != nil) {
		if ([line length] < 1 || [line characterAtIndex:0] == '#')
			continue;
		OFArray *comps = [line componentsSeparatedByCharactersInSet:[OFCharacterSet whitespaceCharacterSet]];
		for (OFString *str in comps)
			if ([str length] > 0)
				[mimeDB setObject:[comps firstObject] forKey:str];
	}
	OFLog(@"Registered %d mime types!", [mimeDB count]);
}

+ (void)initialize {
	if (!initOk) {
		[self loadMimeDB];
		initOk = true;
	}
}

+ (OFString *)mimeTypeFor:(OFString *)extension {
	[self initialize];
	if ([extension length] < 1) // ?
		return @"application/octet-stream";
	OFString *mimeString;
	if ([extension characterAtIndex:0] == '.')
		mimeString = [mimeDB valueForKey:[extension substringFromIndex:1]];
	mimeString = [mimeDB valueForKey:extension];
	if (mimeString == nil)
		return @"application/octet-stream";
	return mimeString;
}

@end