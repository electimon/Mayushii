#import "MYDataManager.h"
#import "MYInitializationException.h"

#include <errno.h>

@implementation MYDataManager

static bool initOk = false;

+ (OFIRI *)getDataDirectory {
	OFIRI *dataDirectory = [OFIRI fileIRIWithPath:[OFString stringWithUTF8String:SYSDATADIR]];
	if (initOk == false) {
		if (![[OFFileManager defaultManager] directoryExistsAtIRI:dataDirectory]) {
			@throw ([MYInitializationException exceptionWithDescription: \
				[OFString stringWithFormat:@"MYDataManager failed to initialize, supporting directory %@ does not exist!", dataDirectory]]);
		}
		initOk = true;
	}
	return dataDirectory;
}

+ (OFIRI *)getDataFileIRI:(OFString *)file {
	OFIRI *fileIRI = [[self getDataDirectory] IRIByAppendingPathComponent:file isDirectory:NO];
	if (![[OFFileManager defaultManager] fileExistsAtIRI:fileIRI]) {
		@throw ([OFOpenItemFailedException exceptionWithIRI:fileIRI mode:@"r" errNo:ENOENT]); // dedicated exception?
	}
	return fileIRI;
}

@end
