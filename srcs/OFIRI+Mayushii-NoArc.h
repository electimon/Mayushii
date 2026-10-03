#import <ObjFW/OFIRI.h>

OF_ASSUME_NONNULL_BEGIN

@interface OFIRI (MayushiiNonArc)

- (void)deleteFirstPathComponent;
- (OFIRI *)IRIByDeletingFirstPathComponent;

@end

OF_ASSUME_NONNULL_END

