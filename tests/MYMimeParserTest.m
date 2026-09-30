#import "MYMimeParserTest.h"
#import "../srcs/MYArgParser.h"
#import "../srcs/MYMimeParser.h"

OF_APPLICATION_DELEGATE(MYMimeParserTest)

@implementation MYMimeParserTest
- (void)applicationDidFinishLaunching: (OFNotification *)notification
{
	OFApplication *app = [OFApplication sharedApplication];
	OFLog(@"mime is : %@", [MYMimeParser mimeTypeFor:@"css"]);
	[OFApplication terminate];
}
@end
