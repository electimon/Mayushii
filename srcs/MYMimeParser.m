#import "MYMimeParser.h"
#import "MYDataManager.h"

@implementation MYMimeParser

static bool initOk = false;
// im the memory monsta!
static OFMutableDictionary *mimeDB;

+ (void)loadMimeDB {
	OFFile *mimeFile = [OFFile fileWithPath:[[MYDataManager getDataFileIRI:@"mime.types"] fileSystemRepresentation] mode:@"r"];
	OFString *line;
	mimeDB = [[OFMutableDictionary alloc] init];
	while ((line = [mimeFile readLine]) != nil) {
		if ([line characterAtIndex:0] == '#')
			continue;
		OFArray *comps = [line componentsSeparatedByCharactersInSet:[OFCharacterSet whitespaceCharacterSet]];
		[mimeDB setObject:[comps firstObject] forKey:[comps lastObject]];
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
	if ([extension characterAtIndex:0] == '.')
		return [mimeDB valueForKey:[extension substringFromIndex:1]];
	return [mimeDB valueForKey:extension];
}

@end