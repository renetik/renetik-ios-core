//
// Created by Rene Dohan on 2019-01-18.
//

#import <Foundation/Foundation.h>

@class CSDictionaryJsonData;

NS_ASSUME_NONNULL_BEGIN

@interface CSJsonData : NSObject

+ (NSArray<CSDictionaryJsonData *> *)reIndex:(NSArray<CSDictionaryJsonData *> *)array;

+ (NSMutableArray<CSDictionaryJsonData *> *)sort:(NSMutableArray<CSDictionaryJsonData *> *)array
        :(NSComparator)comparator;

+ (NSMutableArray<CSDictionaryJsonData *> *)createArray:(Class)type :(nullable NSArray<NSMutableDictionary *> *)array;

+ (NSMutableArray<CSDictionaryJsonData *> *)createArray:(Class)type
                                         fromDictionary:(NSDictionary<NSString *, NSMutableDictionary *> *)dictionary;

+ (NSMutableArray<NSMutableArray<CSDictionaryJsonData *> *> *)createArrayOfArray:(Class)type
        :(NSArray<NSArray<NSDictionary *> *> *)jsonArray;
@end

NS_ASSUME_NONNULL_END