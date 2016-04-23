//
//  UIImage+BDVideoThumbnail.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/9.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BDVideoThumbnail)

+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL;

@end
