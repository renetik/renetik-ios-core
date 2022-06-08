//
// Created by Rene Dohan on 9/10/13.
// Copyright (c) 2013 creative_studio. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import Foundation;

@interface NSData (CSExtension)

+ (instancetype)dataWithContentsOfLink:(NSString *)url;

+ (NSData *)dataWithContentsOfFile:(NSString *)path atOffset:(off_t)offset withSize:(size_t)bytes;

@end