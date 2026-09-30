#import <ObjFW/ObjFW.h>

@interface MYInitializationException : OFObject
@property (nonatomic, retain) OFString *exceptionDescription;

+ (instancetype)exceptionWithDescription:(OFString *)exceptionDescription;
@end