//
// Created by Rene on 2018-11-21.
//

@import Foundation;
#import "CSServerData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CSListData <CSServerData>

- (NSMutableArray *)list;

@end

NS_ASSUME_NONNULL_END