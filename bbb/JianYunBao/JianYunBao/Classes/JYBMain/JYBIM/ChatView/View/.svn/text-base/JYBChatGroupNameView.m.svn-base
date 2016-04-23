//
//  JYBChatGroupNameView.m
//  JianYunBao
//
//  Created by 正 on 16/3/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBChatGroupNameView.h"

@implementation JYBChatGroupNameView

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
    UILabel * leftLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, 80, 21)];
    leftLab.backgroundColor = [UIColor clearColor];
    leftLab.text = @"群名称";
    leftLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:leftLab];
    
    self.groupNameLab = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH - 220, 15, 200, 21)];
    self.groupNameLab.backgroundColor = [UIColor clearColor];
    self.groupNameLab.text = @"群名称";
    self.groupNameLab.textAlignment = NSTextAlignmentRight;
    self.groupNameLab.textColor = [UIColor darkGrayColor];
    self.groupNameLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.groupNameLab];
    
    //按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:self.bounds];
    [button addTarget:self action:@selector(selecteGroupNameAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
- (void)selecteGroupNameAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selecteGroupName)]){
        [self.delegate selecteGroupName];
    }
}

@end
