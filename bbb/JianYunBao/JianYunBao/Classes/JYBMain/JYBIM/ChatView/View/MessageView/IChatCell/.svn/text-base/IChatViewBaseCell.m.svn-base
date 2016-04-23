//
//  IChatViewBaseCell.m
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatViewBaseCell.h"

NSString *const kRouterEventChatHeadImageTapEventName = @"kRouterEventChatHeadImageTapEventName";

@interface IChatViewBaseCell  ()
@property (nonatomic, copy) NSString * currentUserID;
@property (nonatomic, assign) BOOL isSender;
@end

@implementation IChatViewBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithMessageModel:(JYBIChatMessage *)model reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.currentUserID = [RuntimeStatus sharedInstance].userItem.userId;
        self.isSender = [self.currentUserID isEqualToString:model.fromUserID];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImagePressed:)];
        CGFloat originX = HEAD_PADDING;
        if (self.isSender) {
            originX = self.bounds.size.width - HEAD_SIZE - HEAD_PADDING;
        }
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CELLPADDING, HEAD_SIZE, HEAD_SIZE)];
         [_headImageView addGestureRecognizer:tap];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.multipleTouchEnabled = YES;
        _headImageView.backgroundColor = self.backgroundColor;
        [self.contentView addSubview:_headImageView];
        
        [self setupSubviewsForMessageModel:model];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = _headImageView.frame;
    
    frame.origin.x = self.isSender ? (self.bounds.size.width - _headImageView.frame.size.width - HEAD_PADDING) : HEAD_PADDING;
    _headImageView.frame = frame;
    
}

- (void)setMessageEntity:(JYBIChatMessage *)messageEntity
{
    _messageEntity = messageEntity;
//    self.headImageView.backgroundColor = [UIColor redColor];
    UIImage *placeholderImage = [UIImage imageNamed:@"图片默认图标"];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:JYBErpRootUrl(messageEntity.avatar)] placeholderImage:placeholderImage];
}

#pragma mark - private

-(void)headImagePressed:(id)sender
{
    [super routerEventWithName:kRouterEventChatHeadImageTapEventName userInfo:@{KMESSAGEKEY:self.messageEntity}];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [super routerEventWithName:eventName userInfo:userInfo];
}

#pragma mark - public
- (void)setupSubviewsForMessageModel:(JYBIChatMessage *)model
{
    if (self.isSender) {
        self.headImageView.frame = CGRectMake(self.bounds.size.width - HEAD_SIZE - HEAD_PADDING, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
    else{
        self.headImageView.frame = CGRectMake(0, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
}

+ (BOOL)isSender:(JYBIChatMessage *)model
{
    return [[RuntimeStatus sharedInstance].userItem.userId isEqualToString:model.fromUserID];
}

+ (NSString *)cellIdentifierForMessageModel:(JYBIChatMessage *)model
{
    NSString *identifier = @"MessageCell";
    BOOL isSender = [self isSender:model];
    if (isSender) {
        identifier = [identifier stringByAppendingString:@"Sender"];
    }
    else{
        identifier = [identifier stringByAppendingString:@"Receiver"];
    }
    
    switch (model.messageBodyType) {
        case JYBIMMessageBodyTypeText:
            identifier = [identifier stringByAppendingString:@"Text"];
            break;
        case JYBIMMessageBodyTypeAudio:
            identifier = [identifier stringByAppendingString:@"Audio"];
            break;
        case JYBIMMessageBodyTypeImage:
            identifier = [identifier stringByAppendingString:@"Image"];
            break;
        case JYBIMMessageBodyTypeVideo:
            identifier = [identifier stringByAppendingString:@"Video"];
            break;
        case JYBIMMessageBodyTypeFile:
            identifier = [identifier stringByAppendingString:@"File"];
            break;
        default:
            break;
    }
    
    return identifier;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(JYBIChatMessage *)model
{
    return HEAD_SIZE + CELLPADDING;
}
@end
