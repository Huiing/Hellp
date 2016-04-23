//
//  JYBCreateDiscussInputTextView.m
//  JianYunBao
//
//  Created by 正 on 16/4/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBCreateDiscussInputTextView.h"

@implementation JYBCreateDiscussInputTextView

- (id)init{
    if (self = [super init]){
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self initialize];
    }
    return self;
}
- (void)initialize{
    [self addBackgroundImages];
    [self addButton];
}
//添加背景图
- (void)addBackgroundImages{
    CGRect frame = self.bounds;
    frame.size.height -= 6;
    frame.origin.y = 5;
    UIImageView *bgCenter = [[UIImageView alloc] initWithFrame:frame];
    bgCenter.image = [UIImage imageNamed:@"白框_center"];
    bgCenter.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:bgCenter];
    
    frame.origin.y = frame.size.height + 3;
    frame.size.height = 5;
    UIImageView *bgBottom = [[UIImageView alloc] initWithFrame:frame];
    bgBottom.image = [UIImage imageNamed:@"白框_bottom"];
    bgBottom.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:bgBottom];
    
    frame.origin.y = 3;
    UIImageView *bgTop = [[UIImageView alloc] initWithFrame:frame];
    bgTop.image = [UIImage imageNamed:@"白框_top"];
    bgTop.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:bgTop];
}
//添加按钮
- (void)addButton{
    //群名称
    UIImageView * imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 21, 21)];
    imv.image = [UIImage imageNamed:@"任务描述"];
    [self addSubview:imv];
    
    UILabel * leftLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 150, 21)];
    leftLab.backgroundColor = [UIColor clearColor];
    leftLab.text = @"文本内容";
    leftLab.textColor = [UIColor lightGrayColor];
    leftLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:leftLab];
    
    //input
    self.input = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, self.frame.size.width - 20, 35)];
    self.input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.input.layer.borderWidth = 1;
    self.input.layer.cornerRadius = 4;
    self.input.layer.masksToBounds = YES;
    [self addSubview:self.input];
}

@end
