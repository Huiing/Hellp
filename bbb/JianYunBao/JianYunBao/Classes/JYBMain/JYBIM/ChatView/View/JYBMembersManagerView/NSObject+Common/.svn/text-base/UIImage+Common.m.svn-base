//
//  UIImage+Common.m
//  Controls
//
//  Created by C-147 on 13-2-8.
//  Copyright (c) 2013年 C-147. All rights reserved.
//

#import "UIImage+Common.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (Common)

//截取目标View的当前显示为图片
+ (UIImage *)imageFromView:(UIView *)theView
{
	UIGraphicsBeginImageContext(theView.frame.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	[theView.layer renderInContext:context];
	UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return theImage;
}
//返回未被翻转的图片
- (UIImage *)doUnrotateImage
{
    BOOL ROTATED90 = ((self.imageOrientation == UIImageOrientationLeft) || (self.imageOrientation == UIImageOrientationLeftMirrored) || (self.imageOrientation == UIImageOrientationRight) || (self.imageOrientation == UIImageOrientationRightMirrored));
    
	CGSize size = self.size;
	if (ROTATED90) size = CGSizeMake(self.size.height, self.size.width);
	
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGAffineTransform transform = CGAffineTransformIdentity;
    
	// Rotate as needed
	switch(self.imageOrientation)
	{
        case UIImageOrientationLeft:
		case UIImageOrientationRightMirrored:
			transform = CGAffineTransformRotate(transform, M_PI / 2.0f);
			transform = CGAffineTransformTranslate(transform, 0.0f, -size.width);
			size = CGSizeMake(size.height, size.width);
			CGContextConcatCTM(context, transform);
            break;
        case UIImageOrientationRight:
		case UIImageOrientationLeftMirrored:
			transform = CGAffineTransformRotate(transform, -M_PI / 2.0f);
			transform = CGAffineTransformTranslate(transform, -size.height, 0.0f);
			size = CGSizeMake(size.height, size.width);
			CGContextConcatCTM(context, transform);
            break;
		case UIImageOrientationDown:
		case UIImageOrientationDownMirrored:
			transform = CGAffineTransformRotate(transform, M_PI);
			transform = CGAffineTransformTranslate(transform, -size.width, -size.height);
			CGContextConcatCTM(context, transform);
			break;
        default:
			break;
    }
	
    BOOL MIRRORED = ((self.imageOrientation == UIImageOrientationUpMirrored) || (self.imageOrientation == UIImageOrientationLeftMirrored) || (self.imageOrientation == UIImageOrientationRightMirrored) || (self.imageOrientation == UIImageOrientationDownMirrored));
    
	if (MIRRORED)
	{
		// de-mirror
		transform = CGAffineTransformMakeTranslation(size.width, 0.0f);
		transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
		CGContextConcatCTM(context, transform);
	}
    
	// Draw the image into the transformed context and return the image
	[self drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
//返回未被翻转的照片
- (UIImage *)unrotateImage
{
	if (self.imageOrientation == UIImageOrientationUp) return self;
	return [self doUnrotateImage];
}
//为目标尺寸计算合适的尺寸(若在其中则不变，若大于其则取能置其中的最大值按比例缩小)
+ (CGSize)fitSize:(CGSize)thisSize forSize:(CGSize)aSize
{
	CGFloat scale;
	CGSize newsize = thisSize;
	
	if (newsize.height && (newsize.height > aSize.height))
	{
		scale = aSize.height / newsize.height;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	if (newsize.width && (newsize.width >= aSize.width))
	{
		scale = aSize.width / newsize.width;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	
	return newsize;
}
//返回适合大小的图片(居中,若小则不变，若大则按比例缩小)
- (UIImage *)imageByFitForSize:(CGSize)viewsize
{
	// calculate the fitted size
	CGSize size = [[self class] fitSize:self.size forSize:viewsize];
	
	UIGraphicsBeginImageContext(size);
	
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	[self drawInRect:rect];
	
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return newimg;
}
//返回适合大小的图片(居中,若小则画到中间，若大则按比例缩小)
- (UIImage *)imageByFitForFixedSize:(CGSize)viewsize{
    
	// calculate the fitted size
	CGSize size = [[self class] fitSize:self.size forSize:viewsize];
	
	UIGraphicsBeginImageContext(viewsize);
    
	float dwidth = (viewsize.width - size.width) / 2.0f;
	float dheight = (viewsize.height - size.height) / 2.0f;
	
	CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
	[self drawInRect:rect];
	
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return newimg;
}
//返回居中的图片(居中,不改变大小,截掉多余的高宽)
- (UIImage *)imageByCenterForSize:(CGSize)viewsize
{
	CGSize size = self.size;
	
	UIGraphicsBeginImageContext(viewsize);
	float dwidth = (viewsize.width - size.width) / 2.0f;
	float dheight = (viewsize.height - size.height) / 2.0f;
	
	CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
	[self drawInRect:rect];
	
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newimg;
}
//返回填充的图片(居中,按比例填充，使充满整个尺寸,截掉多余的高或宽)
- (UIImage *)imageByFillForSize:(CGSize)viewsize
{
	CGSize size = self.size;
	
	CGFloat scalex = viewsize.width / size.width;
	CGFloat scaley = viewsize.height / size.height;
	CGFloat scale = MAX(scalex, scaley);
	
	UIGraphicsBeginImageContext(viewsize);
	
	CGFloat width = size.width * scale;
	CGFloat height = size.height * scale;
	
	float dwidth = ((viewsize.width - width) / 2.0f);
	float dheight = ((viewsize.height - height) / 2.0f);
	
	CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
	[self drawInRect:rect];
	
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return newimg;
}
//压缩PNG图片
//@param size 要压缩的大小(文件字节数)
-(UIImage*)compressPNGToSize:(NSUInteger)size{
    NSData *data = UIImagePNGRepresentation(self);
    if (data.length < size) {
        return self;
    }
    //缩放比例
    double scale = size / (double)data.length;
    
    const Byte* bytes = data.bytes;
    const Byte* end = bytes + data.length;
    //PNG格式文件头 [PNG数据: 文件头: 89504E47 0D0A1A0A + 数据块（Chunk）* n]
    if(*(UInt64*)bytes == 727905341920923785){//89 50 4E 47 0D 0A 1A 0A
        bytes += 8;
        NSUInteger dataLength = 0;
        //PNG数据块（Chunk）[数据块长度: 4字节 + 数据类型: 4字节 + 数据块: {数据块长度值}字节 + 循环冗余检测: 4字节]
        do {
            UInt32 length = 0;//数据块长度
            Byte* lengthByte = (Byte*)&length;
            *lengthByte = *(bytes+3);
            *(lengthByte + 1) = *(bytes+2);
            *(lengthByte + 2) = *(bytes+1);
            *(lengthByte + 3) = *bytes;
            bytes += 4;
            if(*(UInt32*)bytes == 1413563465){//数据类型: IDAT
                dataLength += length;
            }else if(dataLength != 0){
                break;
            }
            bytes += 4 + length + 4;//数据类型长度 + 数据块长度 + 循环冗余检测长度
        } while (bytes < end);
        scale = (size - (data.length - dataLength)) / (double)dataLength;
    }
    
    if (scale >= 1) {
        return self;
    }
    
    CGFloat area = self.size.width * self.size.height * scale;
    scale = self.size.width / self.size.height;
    CGFloat width = sqrt(area * scale);
    CGSize fitSize = CGSizeMake(width, width / scale);
    
    return [self imageByFitForSize:fitSize];
}

//获取灰度图片
- (UIImage*)grayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return grayImage;
}
@end
