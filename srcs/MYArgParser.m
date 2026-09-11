#import "MYArgParser.h"

@interface MYArgParser ()
@property (nonatomic, retain) OFArray *loadedOptions;
@property (nonatomic) BOOL shouldStdinParse;
@end

@implementation MYArgParser

- (instancetype)initWithOptions:(OFArray<MYArgOption *> *)options enableStdinParsing:(BOOL)enableStdinParsing {
	self = [super init];
	self.loadedOptions = [options copy];
	self.shouldStdinParse = enableStdinParsing;
	return self;
}

+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options enableStdinParsing:(BOOL)enableStdinParsing {
	return [[MYArgParser alloc] initWithOptions:options enableStdinParsing:enableStdinParsing];
}

+ (instancetype)parserWithOptions:(OFArray<MYArgOption *> *)options {
	return [[MYArgParser alloc] initWithOptions:options enableStdinParsing:NO];
}
@end