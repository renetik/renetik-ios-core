//
//  Created by Rene Dohan on 12/30/12.
//

@import Foundation;
NS_ASSUME_NONNULL_BEGIN
@interface CSArgEvent<ObjectType> : NSObject {
    NSMutableArray *_blockArray;
}

- (void)run :(ObjectType)argument;

- (void)add :(void (^)(ObjectType))block;

- (void (^)(ObjectType))last;
@end
NS_ASSUME_NONNULL_END
