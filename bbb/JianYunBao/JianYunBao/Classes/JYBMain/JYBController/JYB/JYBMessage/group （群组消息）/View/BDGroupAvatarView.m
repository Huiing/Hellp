//
//  BDGroupAvatarView.m
//  BDGroupTopicAvatar
//
//  Created by 冰点 on 16/3/19.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDGroupAvatarView.h"

@interface BDGroupAvatarView ()
{
    NSMutableArray *_images;
    NSMutableArray *_subLayers;
}

@end

@implementation BDGroupAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _images = [NSMutableArray array];
        _subLayers = [NSMutableArray array];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        _images = [NSMutableArray array];
        _subLayers = [NSMutableArray array];
    }
    return self;
}

- (void)awakeFromNib
{
    _images = [NSMutableArray array];
    _subLayers = [NSMutableArray array];
    self.backgroundColor = JYBGrayColor;
}

- (void)addAvatarWithUrl:(NSURL *)url
{
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"图片默认图标"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self addAvatar:image];
        self.image = nil;
    }];
}

- (void)addAvatar:(UIImage *)image
{
    [_images addObject:image];
    CALayer *layer = [self imageLyaer];
    layer.contents = (id)image.CGImage;
    [_subLayers addObject:layer];
    [self.layer addSublayer:layer];
}

- (void)addAvatars:(NSArray<UIImage *> *)imgs
{
    for (UIImage *img in imgs) {
        [self addAvatar:img];
    }
}

- (CALayer *)imageLyaer
{
    CALayer *layer = [CALayer layer];
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.frame = CGRectZero;
//    layer.contents = (id)[[UIImage imageNamed:@"avatar"] CGImage];
//    layer.frame = CGRectMake(0, 0, 50, 50);
//    layer.cornerRadius = 50/2.0;
    return layer;
}

- (void)updateSubview
{
    NSUInteger imgTotal = [_images count];
    
    CGFloat width = 0;
    CGSize size = self.frame.size;
    
    if (imgTotal == 1) {
        width = floorf(size.width);
        CALayer *layer = [_subLayers firstObject];
        layer.frame = self.bounds;
        layer.cornerRadius = width / 2.0;
        
    } else if (imgTotal == 2) {
        width = floorf(size.width * 0.7);
        CALayer *layer1 = _subLayers[0];
        CALayer *layer2 = _subLayers[1];
        
        layer1.frame = CGRectMake(0, (size.height - width), width, width);
        layer1.cornerRadius = width / 2.0;
        layer1.zPosition = 1;
        
        layer2.frame = CGRectMake((size.width - width), 0, width, width);
        layer2.cornerRadius = width / 2.0;
        layer2.zPosition = 0;
        
    } else if (imgTotal == 3) {
        width = floorf(size.width * 0.5);
        CALayer *layer1 = _subLayers[0];
        CALayer *layer2 = _subLayers[1];
        CALayer *layer3 = _subLayers[2];
        
        layer1.frame = CGRectMake((size.width - width) * 0.5, 1.5, width, width);
        layer1.cornerRadius = width / 2.0;
        layer1.zPosition = 0;
        
        layer2.frame = CGRectMake(0, (size.height - width) - 1.5, width, width);
        layer2.cornerRadius = width / 2.0;
        layer2.zPosition = 0;
        
        layer3.frame = CGRectMake((size.width - width), (size.height - width) - 1.5, width, width);
        layer3.cornerRadius = width / 2.0;
        layer3.zPosition = 0;
        
    } else if (imgTotal > 3) {
        width = floorf(size.width * 0.5);
        CALayer *layer1 = _subLayers[0];
        CALayer *layer2 = _subLayers[1];
        CALayer *layer3 = _subLayers[2];
        CALayer *layer4 = _subLayers[3];
        
        layer1.frame = CGRectMake(0, 0, width, width);
        layer1.cornerRadius = width / 2.0;
        layer1.zPosition = 0;
        
        layer2.frame = CGRectMake((size.width - width), 0, width, width);
        layer2.cornerRadius = width / 2.0;
        layer2.zPosition = 0;
        
        layer3.frame = CGRectMake(0, (size.height - width), width, width);
        layer3.cornerRadius = width / 2.0;
        layer3.zPosition = 0;
        
        layer4.frame = CGRectMake((size.width - width), (size.height - width), width, width);
        layer4.cornerRadius = width / 2.0;
        layer4.zPosition = 0;
    }
    
}

//- (void)modifyLayerParm:(CALayer *)layer scaleWidth:(CGFloat)width zPosition:(CGFloat)zPosition
//{
//    layer.frame = CGRectMake((self.frame.size.width - width), (self.frame.size.height - width), width, width);
//    layer.cornerRadius = width / 2.0;
//    layer.zPosition = zPosition;
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateSubview];
}

@end
