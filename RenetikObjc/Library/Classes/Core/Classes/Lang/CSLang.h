@import Foundation;

#define stringf(frmt, ...) [NSString stringWithFormat :frmt, __VA_ARGS__]
#define L(key)             NSLocalizedString(key, nil)

static NSTimeInterval const SECOND = 1;
static NSTimeInterval const HALF_SECOND = SECOND / 2;
static NSTimeInterval const MINUTE = 60;
static NSTimeInterval const HOUR = MINUTE * 60;
static NSTimeInterval const DAY = HOUR * 24;
static NSInteger const KB = 1024;
static NSInteger const MB = 1024 * KB;

#ifdef DEBUG
#define DEBUGMODE YES
#else
#define DEBUGMODE NO
#endif

#define let       __auto_type const
#define wlet      __weak __auto_type const
#define var       __auto_type
#define wvar      __weak __auto_type

@interface CSLang : NSObject

void run(void (^block)(void));

id nilToNull(id object);

id nullToNil(id object);

BOOL is(id object);

id stringify(id object);

void doLater(NSTimeInterval delay, void (^block)(void));

void doLaterWith(NSTimeInterval delay, id value, void (^block)(id));

void runWith(void (^block)(id), id value);

//void invoke(void (^block)(void));

void invokeWith(void (^block)(id), id value);

BOOL isDebug(void);

UIEdgeInsets UIEdgeInsetMake(CGFloat inset);

BOOL bitmaskContains(NSUInteger mask, NSUInteger contains);

@end
