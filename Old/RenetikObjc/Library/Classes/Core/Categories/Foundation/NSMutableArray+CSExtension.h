//
//  Created by Rene Dohan on 6/5/12.
//

@import Foundation;

@interface NSMutableArray<ObjectType> (CSExtension)

- (instancetype)construct:(NSArray<ObjectType> *)array;

- (ObjectType)put:(ObjectType)anObject;

- (ObjectType)set:(ObjectType)anObject;

- (ObjectType)add:(ObjectType)anObject :(NSUInteger)index;

- (id)set:(id)anObject :(NSUInteger)index;

- (ObjectType)replaceObject:(ObjectType)newObject :(ObjectType)oldObject;

- (instancetype)addArray:(NSArray *)array;

- (instancetype)remove:(id)anObject;

- (instancetype)removeAll:(NSArray *)array;

- (instancetype)reload:(NSArray *)array;

- (instancetype)reverse;

- (instancetype)removeLast;

- (NSString *)joinBy:(NSString *)string;
@end
