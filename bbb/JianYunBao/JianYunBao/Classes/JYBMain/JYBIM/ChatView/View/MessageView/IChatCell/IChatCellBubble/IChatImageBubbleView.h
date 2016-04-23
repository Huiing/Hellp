//
//  IChatImageBubbleView.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatBaseBubbleView.h"

#define MAX_SIZE 120 //　图片最大显示大小

extern NSString *const kRouterEventImageBubbleTapEventName;

@interface IChatImageBubbleView : IChatBaseBubbleView

@property (nonatomic, strong) UIImageView *imageView;

@end
