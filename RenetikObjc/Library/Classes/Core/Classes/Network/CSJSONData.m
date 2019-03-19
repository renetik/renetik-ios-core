//
// Created by Rene Dohan on 2019-01-18.
//

#import "CSLang.h"
#import "CSJsonData.h"
#import "CSDictionaryJsonData.h"
#import "NSMutableArray+CSExtension.h"

@implementation CSJsonData

+ (NSArray<CSDictionaryJsonData *> *)reIndex:(NSArray<CSDictionaryJsonData *> *)array {
    var index = 0;
    for (CSDictionaryJsonData *data in array) data.index = index++;
    return array;
}

+ (NSMutableArray<CSDictionaryJsonData *> *)sort:(NSMutableArray<CSDictionaryJsonData *> *)array
        :(NSComparator)comparator {
    return [NSMutableArray.new construct:[self reIndex:[array sortedArrayUsingComparator:comparator]]];
}

+ (NSMutableArray<CSDictionaryJsonData *> *)createArray:(Class)type :(NSArray<NSMutableDictionary *> *)array {
    if (!array) return nil;
    NSMutableArray<CSDictionaryJsonData *> *dataArray = NSMutableArray.new;
    uint count = 0;
    for (NSMutableDictionary *value in array)
        [dataArray put:[(CSDictionaryJsonData *) type.new load:value]].index = count++;
    return dataArray;
}

+ (NSMutableArray<CSDictionaryJsonData *> *)createArray:(Class)type
                                         fromDictionary:(NSDictionary<NSString *, NSMutableDictionary *> *)dictionary {
    if (!dictionary) return nil;
    NSMutableArray<CSDictionaryJsonData *> *dataArray = NSMutableArray.new;
    uint count = 0;
    for (NSString *key in dictionary) {
        let data = [dataArray put:[(CSDictionaryJsonData *) type.new load:dictionary[key]]];
        data.key = key;
        data.index = count++;
    }
    return dataArray;
}

+ (NSMutableArray<NSMutableArray<CSDictionaryJsonData *> *> *)createArrayOfArray:(Class)type
        :(NSArray<NSArray<NSDictionary *> *> *)jsonArray {
    if (!jsonArray) return nil;
    NSMutableArray<NSMutableArray<CSDictionaryJsonData *> *> *dataArray = NSMutableArray.new;
    for (NSArray<NSMutableDictionary *> *arrayOfDictionaries in jsonArray)
        [dataArray put:[self createArray:type :arrayOfDictionaries]];
    return dataArray;
}

@end
