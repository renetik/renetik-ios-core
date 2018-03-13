//
// Created by Rene Dohan on 17/07/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSSharePhotoButtonsListener <NSObject>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)data;

@end