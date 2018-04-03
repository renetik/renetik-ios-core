#import <Foundation/Foundation.h>

#define stringf(frmt, ...)  [NSString stringWithFormat:frmt,__VA_ARGS__]
#define L(key) NSLocalizedString(key, nil)

static int const SECOND = 1;
static int const MINUTE = 60;
static int const HOUR = MINUTE * 60;
static int const DAY = HOUR * 24;

#ifdef DEBUG
#define DEBUGMODE YES
#else
#define DEBUGMODE NO
#endif

#define let __auto_type const
#define var __auto_type
#define wvar __weak __auto_type

@interface CSLang : NSObject

void run(void (^block)(void));

id nilToNull(id object);

id nullToNil(id object);

id stringify(id object);

NSMutableArray *muteArray(NSArray *array);

NSMutableDictionary *muteDict(NSDictionary *array);

void runWith(void (^block)(id), id value);

void doLater(void (^block)(void), NSTimeInterval delay);

void invoke(void (^block)(void));

void showMessage(NSString *title);

void doLaterWith(void (^block)(id), id value, NSTimeInterval delay);

void invokeWith(void (^block)(id), id value);

BOOL isDebug(void);

NSString *format(NSString *format, NSObject *argument);

NSString *format2(NSString *format, NSObject *argument, NSObject *argument2);

NSString *format3(NSString *format, NSObject *argument, NSObject *argument2, NSObject *argument3);

NSString *format4(NSString *format, NSObject *argument, NSObject *argument2, NSObject *argument3, NSObject *argument4);

@end
