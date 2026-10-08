#import "MYSemaphore.h"
#import "MYInitializationException.h"

#import <semaphore.h>

@implementation MYSemaphore {
    sem_t sema;
}

+ (instancetype)semaphore:(int)initialValue {
    MYSemaphore *klazz = [[MYSemaphore alloc] init];
    int ret = sem_init(&klazz->sema, 0, initialValue);
    if (ret == -1)
        @throw ([MYInitializationException exceptionWithDescription:@"Failed to create the sempahore!"]);
    return klazz;
}

- (BOOL)wait {
    int ret = 0;
    ret = sem_wait(&sema);
    return (ret == 0);
}

- (BOOL)signal {
    int ret = 0;
    ret = sem_post(&sema);
    return (ret == 0);
}

- (void)dealloc {
    if (&sema != NULL)
        sem_destroy(&sema);
}

@end