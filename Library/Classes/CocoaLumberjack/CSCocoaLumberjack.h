//
// Created by Rene Dohan on 05/03/18.
// Copyright (c) 2018 Renetik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

CF_ASSUME_NONNULL_BEGIN

static const DDLogLevel ddLogLevel = DDLogLevelInfo;

#define infoInt(int)    DDLogInfo(@"%i", int)
#define infoDbl(double)    DDLogInfo(@"%f", double)
#define infoBool(BOOL_VAL)    DDLogInfo(@"%s", BOOL_VAL ? "Yes" : "No")
#define info(NSObject)    DDLogInfo(@"%@",NSObject)
#define infof(frmt, ...)    DDLogInfo(frmt, __VA_ARGS__)
#define error(NSObject)    DDLogError(@"%@",NSObject)
#define errorf(frmt, ...)    DDLogError(frmt, __VA_ARGS__)
#define warn(NSObject)    DDLogWarn(@"%@",NSObject)
#define warnf(frmt, ...)    DDLogWarn(frmt, __VA_ARGS__)

CF_ASSUME_NONNULL_END
