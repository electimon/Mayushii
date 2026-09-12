#import "MYArgParserTest.h"
#import "../srcs/MYArgParser.h"

OF_APPLICATION_DELEGATE(MYArgParserTest)

@implementation MYArgParserTest
- (void)applicationDidFinishLaunching: (OFNotification *)notification
{
	OFApplication *app = [OFApplication sharedApplication];
    OFArray *arguments = [app arguments];
	MYArgParser *parser = [MYArgParser parserWithOptions:@[
		[MYArgOption optionWithLongForm:@"long-ass-option"],
		[MYArgOption optionWithLongForm:@"long-ass-option-with-short-form" andShortForm:@"x"],
		[MYArgOption optionWithLongForm:@"long" shortForm:@"l" valueType:[OFNumber class] withImplictValue:[OFNumber numberWithLong:2]],
		[MYArgOption optionWithLongForm:@"short" valueType:[OFString class] withImplictValue:@"nooo"]
	]];
	OFLog(@"matches = %@", [parser getMatches:[app arguments]]);
	[OFApplication terminate];
}
@end
