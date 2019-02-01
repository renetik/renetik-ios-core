//
//  Created by Rene Dohan on 12/30/12.
//

@import Foundation;

@interface CSArgEvent<__covariant ObjectType> : NSObject {
    NSMutableArray *_blockArray;
}

- (void)run:(ObjectType)argument;

- (void)add:(void (^)(ObjectType))block;

- (void (^)(ObjectType))last;
@end