//
// Created by Rene Dohan on 9/10/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSFileManager+CSExtension.h"

@implementation NSFileManager (CSExtension)

+ (long)fileLength:(NSString *)path {
    NSError *attributesError;
    NSDictionary *fileAttributes = [NSFileManager.defaultManager attributesOfItemAtPath:path error:&attributesError];
    if (attributesError)NSLog(attributesError.description);
    NSNumber *fileSizeNumber = fileAttributes[NSFileSize];
    return fileSizeNumber.longValue;
}

@end