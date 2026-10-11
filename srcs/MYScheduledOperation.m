#import "MYScheduledOperation.h"

@implementation MYScheduledOperation {
    OFTimer *timer;
    OFThread *thread;
    MYScheduledOperationOperation op;
}

- (instancetype)initSchedule:(double)interval operation:(__strong MYScheduledOperationOperation)opBlock {
    self = [super init];
    self->op = [opBlock copy];
    self->thread = [[OFThread alloc] initWithBlock:^id{
        self->timer = [OFTimer scheduledTimerWithTimeInterval:interval repeats:YES block:^(OFTimer * _Nonnull timer) {
            self->op();
        }];
        OFLog(@"running!");
        [self->timer fire];
        [[OFRunLoop currentRunLoop] run];
        return nil;
    }];
    [self->thread start]; 
    return self;
}

+ (instancetype)schedule:(double)interval operation:(__strong MYScheduledOperationOperation)op {
    return [[self alloc] initSchedule:interval operation:op];
}

@end