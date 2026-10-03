#import "MYIRITest.h"
#import "../srcs/OFIRI+Mayushii.h"

OF_APPLICATION_DELEGATE(MYIRITest)

@implementation MYIRITest
- (void)applicationDidFinishLaunching: (OFNotification *)notification
{
	OFApplication *app = [OFApplication sharedApplication];
	OFIRI *iri = [OFIRI IRIWithString:@"http://a/bb/c/"];
	OFLog(@"hey: %@", [iri IRIByDeletingFirstPathComponent]);
	[OFApplication terminate];
}
@end
