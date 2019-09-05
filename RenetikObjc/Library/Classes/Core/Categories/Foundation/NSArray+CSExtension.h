//
//  Created by Rene Dohan on 5/9/12.
//


@import Foundation;

@interface NSArray<ObjectType> (CSExtension)

@property(readonly) BOOL empty;
@property(readonly) BOOL hasItems;
@property(readonly) NSInteger lastIndex;
@property(readonly) NSInteger size;
@property(readonly) BOOL set;
@property(readonly) _Nullable ObjectType first;
@property(readonly) _Nullable ObjectType second;
@property(readonly) _Nullable ObjectType last;

+ (NSArray<NSString *> *)toStringList:(NSArray<NSObject *> *)names;

+ (NSArray<NSNumber *> *)toNumberList:(NSArray<NSObject *> *)stringList;

- (ObjectType)objectAs:(ObjectType)anObject;

- (BOOL)contains:(id)anObject;

- (NSInteger)indexOf:(id)anObject;

- (nullable ObjectType)at:(NSInteger)index;

- (nullable ObjectType)get:(NSInteger)index;

- (BOOL)equals:(NSArray *)array;

- (NSArray *)filterBySearch:(NSString *)searchText;

- (NSString *)jsonString;
@end
