//
//  UIImage+Common.h
//  Controls
//
//  Created by C-147 on 13-2-8.
//  Copyright (c) 2013年 C-147. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

//截取目标View的当前显示为图片
+ (UIImage *)imageFromView:(UIView *)theView;

//返回未被翻转过的图片
- (UIImage *)unrotateImage;

//为目标尺寸计算合适的尺寸(若在其中则不变，若大于其则取能置其中的最大值按比例缩小)
+ (CGSize) fitSize:(CGSize)thisSize forSize:(CGSize)aSize;
//返回适合大小的图片(居中,若小则不变，若大则按比例缩小)
- (UIImage *)imageByFitForSize:(CGSize)size;
//返回适合大小的图片(居中,若小则画到中间，若大则按比例缩小)
- (UIImage *)imageByFitForFixedSize:(CGSize)size;
//返回居中的图片(居中,不改变大小,截掉多余的高宽)
- (UIImage *)imageByCenterForSize:(CGSize)size;
//返回填充的图片(居中,按比例填充，使充满整个尺寸,截掉多余的高或宽)
- (UIImage *)imageByFillForSize:(CGSize)size;

//压缩PNG图片
//@param size 要压缩的大小(文件字节数)
-(UIImage*)compressPNGToSize:(NSUInteger)size;

//获取灰度图片
-(UIImage*)grayImage;
@end
