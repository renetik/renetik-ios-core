//
// Created by Rene Dohan on 9/10/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSData+CSExtension.h"


@implementation NSData (CSExtension)

+ (instancetype)dataWithContentsOfLink:(NSString *)url {
    return [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
}

+ (NSData *)dataWithContentsOfFile:(NSString *)path atOffset:(off_t)offset withSize:(size_t)bytes {
    FILE *file = fopen([path UTF8String], "rb");
    if (file == NULL)
        return nil;

    void *data = malloc(bytes);
    fseeko(file, offset, SEEK_SET);
    fread(data, 1, bytes, file);
    fclose(file);

    return [NSData dataWithBytesNoCopy:data length:bytes];
}
@end