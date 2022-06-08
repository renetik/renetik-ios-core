//
//  Created by Rene Dohan on 5/9/12.
//


@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (CSExtension)

@property(readonly) BOOL empty;
@property(readonly) BOOL hasItems;
@property(readonly) NSInteger lastIndex;
@property(readonly) NSInteger size;
@property(readonly) BOOL set;
@property(readonly) _Nullable ObjectType first;
@property(readonly) _Nullable ObjectType second;
@property(readonly) _Nullable ObjectType last;
@property(readonly) _Nullable ObjectType beforeLast;

+ (NSArray<NSString *> *)toStringList:(NSArray<NSObject *> *)names;

+ (NSArray<NSNumber *> *)toNumberList:(NSArray<NSObject *> *)stringList;

- (ObjectType)objectAs:(ObjectType)anObject;

- (BOOL)contains:(id)anObject;

- (NSInteger)indexOf:(id)anObject;

- (nullable ObjectType)at:(NSInteger)index;

- (nullable ObjectType)get:(NSInteger)index;

- (nullable ObjectType)getPreviousOf:(ObjectType)anObject;

- (BOOL)equals:(NSArray *)array;

- (NSArray *)filterBySearch:(NSString *)searchText;

- (NSString *)jsonString;

- (NSMutableArray<ObjectType> *)mutable;
@end

NS_ASSUME_NONNULL_END
