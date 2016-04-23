//
//  IChatViewBaseCell.h
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBIChatMessage.h"
#import "IChatBaseBubbleView.h"
#import "UIResponder+Router.h"

#define HEAD_SIZE 40 // 头像大小
#define HEAD_PADDING 5 // 头像到cell的内间距和头像到bubble的间距
#define CELLPADDING 8 // Cell之间间距

#define NAME_LABEL_WIDTH 180 // nameLabel最大宽度
#define NAME_LABEL_HEIGHT 20 // nameLabel 高度
#define NAME_LABEL_PADDING 5 // nameLabel间距
#define NAME_LABEL_FONT_SIZE 14 // 字体

extern NSString *const kRouterEventChatHeadImageTapEventName;

@interface IChatViewBaseCell : UITableViewCell
{
    IChatBaseBubbleView *_bubbleView;
}

@property (nonatomic, strong) JYBIChatMessage *messageEntity;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) IChatBaseBubbleView *bubbleView;

@property (nonatomic, readonly, assign) BOOL isSender;
+ (BOOL)isSender:(JYBIChatMessage *)model;

- (id)initWithMessageModel:(JYBIChatMessage *)model reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupSubviewsForMessageModel:(JYBIChatMessage *)model;

+ (NSString *)cellIdentifierForMessageModel:(JYBIChatMessage *)model;
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(JYBIChatMessage *)model;
@end
