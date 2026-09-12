#import "MYArgParserTest.h"
#import "../srcs/MYArgParser.h"

OF_APPLICATION_DELEGATE(MYArgParserTest)

@implementation MYArgParserTest
- (void)applicationDidFinishLaunching: (OFNotification *)notification
{
	OFApplication *app = [OFApplication sharedApplication];
    int *argc;
    char ***argv;
    [app getArgumentCount:&argc andArgumentValues:&argv];
	MYArgParser *parser = [MYArgParser parserWithOptions:@[
		[MYArgOption optionWithLongForm:@"long-ass-option"],
		[MYArgOption optionWithLongForm:@"long-ass-option-with-short-form" andShortForm:@"x"],
		[MYArgOption optionWithLongForm:@"long" shortForm:@"l" valueType:[OFNumber class] withImplictValue:[OFNumber numberWithLong:2]],
		[MYArgOption optionWithLongForm:@"short" valueType:[OFString class] withImplictValue:@"nooo"]
	]];
	OFLog(@"matches = %@", [parser getMatchesForArgc:*argc andArgv:*argv]);
	[OFApplication terminate];
}
@end
