@import Foundation;

#define stringf(frmt, ...) [NSString stringWithFormat :frmt, __VA_ARGS__]
#define L(key)             NSLocalizedString(key, nil)

static NSTimeInterval const SECOND = 1;
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

NSMutableArray * muteArray(NSArray *array);

NSMutableDictionary * muteDict(NSDictionary *array);

void runWith(void (^block)(id), id value);

void doLater(NSInteger delay, void (^block)(void));

void invoke(void (^block)(void));

void showMessage(NSString *title);

void doLaterWith(void (^block)(id), id value, NSTimeInterval delay);

void invokeWith(void (^block)(id), id value);

BOOL isDebug(void);

NSString * format(NSString *format, NSObject *argument);

NSString * format2(NSString *format, NSObject *argument, NSObject *argument2);

NSString * format3(NSString *format, NSObject *argument, NSObject *argument2, NSObject *argument3);

NSString * format4(NSString *format, NSObject *argument, NSObject *argument2, NSObject *argument3, NSObject *argument4);

UIEdgeInsets UIEdgeInsetMake(CGFloat inset);

BOOL bitmaskContains(NSUInteger bitmask, NSUInteger containns);

@end
