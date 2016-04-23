//
//  UIImage+BDVideoThumbnail.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/9.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "UIImage+BDVideoThumbnail.h"

@implementation UIImage (BDVideoThumbnail)

//获取视频封面，本地视频，网络视频都可以用
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL {
    
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform= YES;
    
    CMTime time =CMTimeMakeWithSeconds(2.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    
    return thumbImg;
    
}

@end
