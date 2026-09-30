#import <ObjFW/ObjFW.h>

@interface MYDataManager : OFObject

+ (OFIRI *)getDataDirectory;
+ (OFIRI *)getDataFileIRI:(OFString *)file;

@end