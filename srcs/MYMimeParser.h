#import <ObjFW/ObjFW.h>

@interface MYMimeParser : OFObject

+ (OFString *)mimeTypeFor:(OFString *)extension;

@end