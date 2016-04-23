//
//  JYBMultiContainerView.m
//  JianYunBao
//
//  Created by 正 on 16/3/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMultiContainerView.h"
#import "UIView+GridLayout.h"
#import "UIButton+WebCache.h"
#import "NSObject+Common.h"

#define ITEM_ICON_SIZE CGSizeMake(44, 44)
#define ITEM_REMOVE_SIZE CGSizeMake(22, 24)
#define ITEM_SIZE CGSizeMake(55, 12 + 44 + 21)
#define CONTAINER_VIEW_TAG -10000
#define ADD_BUTTON_TAG -9999
#define REMOVE_BUTTON_TAG -9998
#define ITEM_REMOVE_BUTTON_TAG -8888

#define ADJUST_X 5
#define ADJUST_Y 5

@implementation JYBMultiContainerView

- (id)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
-(void)setIsAllShows:(BOOL)isAllShows{
    if (_isAllShows != isAllShows) {
        _isAllShows = isAllShows;
        if (isAllShows) {
            [self showMore];
        }else{
            [self hideMore];
        }
    }
}
-(void)setIsAddable:(BOOL)isAddable{
    if (_isAddable != isAddable) {
        if (isAddable) {
            _isAddButtonShowing = NO;
            [self addAddButton];
        }else{
            _isAddButtonShowing = YES;
            [self removeAddButton];
        }
        _isAddable = isAddable;
    }
}
-(void)setIsRemoveable:(BOOL)isRemoveable{
    if (_isRemoveable != isRemoveable) {
        if (isRemoveable) {
            [self addRemoveButton];
        }else{
            self.isRemoving = NO;
            [self removeRemoveButton];
        }
        _isRemoveable = isRemoveable;
    }
}
-(void)setIsRemoving:(BOOL)isRemoving{
    if (self.isRemoveable) {
        if (_isRemoving != isRemoving) {
            _isRemoving = isRemoving;
            if (isRemoving) {
                [self showRemoveButtons];
            }else{
                [self hideRemoveButtons];
            }
        }
    }
}
- (void)initialize{
    _personsDatas = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor clearColor];
    [self addBackgroundImages];
    //添加查看全部按钮
    _showMoreView = [[UIView alloc] init];
    [self initShowMoreView];
    _container = [[UIView alloc] initWithFrame:self.bounds];
    [self initContainer];
    _isAllShows = NO;
    _isAddable = YES;
    _isAddButtonShowing = NO;
    _isRemoveable = NO;
    _isRemoving = NO;
}
//初始化容器
- (void)initContainer{
    self.container.tag = CONTAINER_VIEW_TAG;
    self.container.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:self.container];
}
//初始化显示更多视图
- (void)initShowMoreView{
    CGRect frame = self.bounds;
    frame.size.height = 40.0f;
    frame.origin.y = self.bounds.size.height - frame.size.height;
    self.showMoreView.frame = frame;
    self.showMoreView.backgroundColor = [UIColor clearColor];
    self.showMoreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    //上面的间隔线
    frame.size.height = 1.0f;
    frame.origin.y = 0;
    UIView *topLine = [[UIView alloc] initWithFrame:frame];
    topLine.backgroundColor = [UIColor colorWithWhite:0.89803922 alpha:1];
    [self.showMoreView addSubview:topLine];
    //查看全部按钮
    frame.size.height = self.showMoreView.bounds.size.height - 2.0f;
    frame.origin.y = 1.0f;
    frame.origin.x = 1.0f;
    frame.size.width -= 2.0f;
    UIButton *showMoreButton = [[UIButton alloc] initWithFrame:frame];
    showMoreButton.backgroundColor = [UIColor whiteColor];
    showMoreButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [showMoreButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
    [showMoreButton setTitle:NSLocalizedString(@"点击查看更多...", nil) forState:UIControlStateNormal];
    if (IOS_VERSION < 6.0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMore:)];
        [showMoreButton addGestureRecognizer:tap];
    }else{
        [showMoreButton addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.showMoreView addSubview:showMoreButton];
    _showMoreButton = showMoreButton;
    [self addSubview:self.showMoreView];
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
- (void)showMore:(id)sender{
    self.isAllShows = YES;
}
- (int)maxShowCount{
    return self.isAllShows ? -1 : (self.isRemoveable ? 8 : 9);
}
//显示全部
- (void)showMore{
    if (self.isAllShows) {
        for (int i = 0; i < self.personsDatas.count; i++) {
            UIView *personView = [self.container viewWithTag:i];
            if (!personView) {
                [self addPersonView:self.personsDatas[i] withTag:i];
            }
        }
        [self relayoutViewWithAnimated:YES];
    }
}
//只显示一部分
- (void)hideMore{
    if (!self.isAllShows) {
        int maxShowCount = [self maxShowCount];
        if (maxShowCount == -1) {
            maxShowCount = self.personsDatas.count;
        }
        for (int i = maxShowCount; i < self.personsDatas.count; i++) {
            UIView *personView = [self.container viewWithTag:i];
            if (personView) {
                [personView removeFromSuperview];
            }
        }
        [self relayoutViewWithAnimated:YES];
    }
}
/**
 *添加一组人
 */
- (void)addPersons:(NSArray*)persons{
    [self addPersons:persons withAnimated:NO];
}
/**
 *添加一组人
 */
- (void)addPersons:(NSArray*)persons withAnimated:(BOOL)animated{
    if (self.isAddable && !_isAddButtonShowing) {
        [self addAddButton];
    }
    //如果只显示部分，则超出部分不显示
    int maxShowCount = [self maxShowCount];
    if (maxShowCount == -1) {
        maxShowCount = self.personsDatas.count + persons.count;
    }
    for (int i = 0; i < persons.count; i++) {
        NSDictionary *person = persons[i];
        if (self.personsDatas.count < maxShowCount) {
            [self addPersonView:person withTag:self.personsDatas.count];
        }
        [(NSMutableArray*)self.personsDatas addObject: person];
    }
    [self relayoutViewWithAnimated:animated];
}
/**
 *添加一个人
 */
- (void)addPerson:(NSDictionary*)person{
    [self addPerson:person withAnimated:NO];
}
/**
 *添加一个人
 */
- (void)addPerson:(NSDictionary*)person withAnimated:(BOOL)animated{
    if (self.isAddable && !_isAddButtonShowing) {
        [self addAddButton];
    }
    //如果只显示部分，则超出部分不显示
    int maxShowCount = [self maxShowCount];
    if (maxShowCount == -1 || self.personsDatas.count < maxShowCount) {
        [self addPersonView:person withTag:self.personsDatas.count];
    }
    [(NSMutableArray*)self.personsDatas addObject:person];
    [self relayoutViewWithAnimated:animated];
}
/**
 *	@brief	移除一个人
 */
- (void)removePerson:(NSDictionary*)person{
    [self removePerson:person withAnimated:NO];
}
/**
 *	@brief	移除一个人
 */
- (void)removePerson:(NSDictionary*)person withAnimated:(BOOL)animated{
    BOOL resetTag = NO;
    for (int i = 0; i < self.personsDatas.count; i++) {
        if (resetTag) {
            UIView *personView = [self.container viewWithTag:i+1];
            if (personView) {
                personView.tag = i;
            }
        }else if (person == self.personsDatas[i]) {
            UIView *personView = [self.container viewWithTag:i];
            if (personView) {
                [personView removeFromSuperview];
            }
            [((NSMutableArray*)self.personsDatas) removeObjectAtIndex:i];
            resetTag = YES;
            i--;
        }
    }
    if (resetTag) {
        [self relayoutViewWithAnimated:animated];
    }
}
-(void)removeAllPersons{
    [self removeAllPersonsWithAnimated:NO];
}
-(void)removeAllPersonsWithAnimated:(BOOL)animated{
    for (int i = 0; i < self.personsDatas.count; i++) {
        UIView *personView = [self.container viewWithTag:i];
        if (personView) {
            [personView removeFromSuperview];
        }
    }
    [((NSMutableArray*)self.personsDatas) removeAllObjects];
    
    [self relayoutViewWithAnimated:animated];
}
//添加一个人员View
- (void)addPersonView:(NSDictionary*)person withTag:(NSInteger)tag{
    UIView *personView = [[UIView alloc] init];
    personView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;;
    CGRect frame = CGRectMake(0, 0, 0, 0);
    frame.size = ITEM_SIZE;
    personView.frame = frame;
    personView.tag = tag;
    
    UIButton *removeButton = [[UIButton alloc] init];
    removeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [removeButton setBackgroundImage:[UIImage imageNamed:@"减少.png"] forState:UIControlStateNormal];
    frame = CGRectMake(-ADJUST_X, 0, 0, 0);
    frame.size = ITEM_REMOVE_SIZE;
    removeButton.frame = frame;
    removeButton.tag = ITEM_REMOVE_BUTTON_TAG;
    removeButton.hidden = !self.isRemoving;
    
    [removeButton addTarget:self action:@selector(personRemove:) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize iconSize = ITEM_ICON_SIZE;
    UIButton *imageButton = [[UIButton alloc] init];
    imageButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    frame = CGRectMake(0, 0, 0, 0);
    frame.size = ITEM_ICON_SIZE;
    frame.origin.x = removeButton.frame.size.width / 2 - ADJUST_X;
    frame.origin.y = removeButton.frame.size.height / 2;
    imageButton.frame = frame;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,person[@"iconPaths"]];
    
    [imageButton setBackgroundImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
    
    [imageButton addTarget:self action:@selector(personSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    frame = CGRectMake(0, iconSize.height + imageButton.frame.origin.y, personView.frame.size.width, personView.frame.size.height - iconSize.height - imageButton.frame.origin.y);
    label.frame = frame;
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:person[@"name"]];
    
    [personView addSubview:imageButton];
    [personView addSubview:label];
    [personView addSubview:removeButton];
    
    [self.container addSubview:personView];
    
}
//添加添加人员按钮
- (void)addAddButton{
    if (_isAddButtonShowing) return;
    if ([self.container viewWithTag:ADD_BUTTON_TAG]) return;
    UIView *personView = [[UIView alloc] init];
    personView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;;
    CGRect frame = CGRectMake(0, 0, 0, 0);
    frame.size = ITEM_SIZE;
    frame.size.height += 21;
    personView.frame = frame;
    personView.tag = ADD_BUTTON_TAG;
    
    UIButton *imageButton = [[UIButton alloc] init];
    imageButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;;
    frame = CGRectMake(0, 0, 0, 0);
    frame.size = ITEM_ICON_SIZE;
    frame.origin.y = (ITEM_SIZE.height - frame.size.height)/2 - ADJUST_Y;
    frame.origin.x = (ITEM_SIZE.width - frame.size.width) - ADJUST_X;
    imageButton.frame = frame;
    imageButton.tag = ADD_BUTTON_TAG;
    
    [imageButton setBackgroundImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    
    [imageButton addTarget:self action:@selector(personAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [personView addSubview:imageButton];
    
    [self.container addSubview:personView];
    _isAddButtonShowing = YES;
}
//移除添加人员按钮
-(void)removeAddButton{
    UIView *addButton = [self.container viewWithTag:ADD_BUTTON_TAG];
    if (addButton) {
        [addButton removeFromSuperview];
    }
}
//添加移除人员按钮
- (void)addRemoveButton{
    if ([self.container viewWithTag:REMOVE_BUTTON_TAG]) return;
    UIView *personView = [[UIView alloc] init];
    personView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;;
    CGRect frame = CGRectMake(0, 0, 0, 0);
    frame.size = ITEM_SIZE;
    frame.size.height += 21;
    personView.frame = frame;
    personView.tag = REMOVE_BUTTON_TAG;
    
    UIButton *imageButton = [[UIButton alloc] init];
    imageButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;;
    frame = CGRectMake(0, 0, 0, 0);
    frame.size = ITEM_ICON_SIZE;
    frame.origin.y = (ITEM_SIZE.height - frame.size.height)/2 - ADJUST_Y;
    frame.origin.x = (ITEM_SIZE.width - frame.size.width)- ADJUST_X;
    imageButton.frame = frame;
    imageButton.tag = REMOVE_BUTTON_TAG;
    
    [imageButton setBackgroundImage:[UIImage imageNamed:@"减少.png"] forState:UIControlStateNormal];
    
    [imageButton addTarget:self action:@selector(personRemoving:) forControlEvents:UIControlEventTouchUpInside];
    
    [personView addSubview:imageButton];
    
    [self.container addSubview:personView];
}
//移除移除人员按钮
- (void)removeRemoveButton{
    UIView *removeButton = [self.container viewWithTag:REMOVE_BUTTON_TAG];
    if (removeButton) {
        [removeButton removeFromSuperview];
    }
}
- (void)showRemoveButtons{
    if (self.isRemoving) {
        for (UIView *view in self.container.subviews) {
            UIView *removeButton = [view viewWithTag:ITEM_REMOVE_BUTTON_TAG];
            if (removeButton) {
                NSDictionary *person = self.personsDatas[[removeButton superview].tag];
                //若是登陆人则不给删除
                if ([person[@"id"] isEqualToString:JYB_userId]) {
                    removeButton.hidden = YES;
                }else{
                    removeButton.hidden = NO;
                }
            }
        }
    }
}
- (void)hideRemoveButtons{
    if (!self.isRemoving) {
        for (UIView *view in self.container.subviews) {
            UIView *removeButton = [view viewWithTag:ITEM_REMOVE_BUTTON_TAG];
            if (removeButton) {
                removeButton.hidden = YES;
            }
        }
    }
}
//重新布局
- (void)relayoutViewWithAnimated:(BOOL)animated{
    //把添加按钮放到最后
    UIView *addButton = [self.container viewWithTag:ADD_BUTTON_TAG];
    if (addButton) {
        [self.container bringSubviewToFront:addButton];
    }
    //把移除按钮放到最后
    UIView *removeButton = [self.container viewWithTag:REMOVE_BUTTON_TAG];
    if (removeButton) {
        [self.container bringSubviewToFront:removeButton];
    }
    if (animated) {
        [UIView beginAnimations:@"relayoutView" context:nil];
    }
    CGRect frame = self.frame;
    CGFloat needMoveYValue = frame.origin.y + frame.size.height;
    CGSize size = [self.container layoutSubviewsWithSize:ITEM_SIZE spacing:CGPointMake(0, 0)];
    CGFloat offset = size.height - frame.size.height;
    self.container.frame = CGRectMake(0, 0, size.width, size.height);
    //添加点击查看全部
    int maxShowCount = [self maxShowCount];
    if (maxShowCount == -1 || self.personsDatas.count <= maxShowCount) {
        self.showMoreView.alpha = 0;
    }else{
        size.height += self.showMoreView.frame.size.height;
        offset += self.showMoreView.frame.size.height;
        self.showMoreView.alpha = 1;
        [self.showMoreButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"点击查看全部成员(%d)", nil),self.personsDatas.count] forState:UIControlStateNormal];
    }
    frame.size = size;
    self.frame = frame;
    
    //将该View的所有同级View的位置偏移
    UIView *superView = self.superview;
    for (UIView *view in superView.subviews) {
        if (view.frame.origin.y >= needMoveYValue) {
            frame = view.frame;
            frame.origin.y += offset;
            view.frame = frame;
        }
    }
    //如果父View是ScrollView的话则重设ContentSize
    if ([superView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)superView;
        CGSize contentSize = scrollView.contentSize;
        contentSize.height += offset;
        scrollView.contentSize = contentSize;
    }
    if (animated) {
        [UIView commitAnimations];
    }
}
//点击人员
- (void)personSelect:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(multiplayerContainerView:actionForSelectedPerson:)]) {
        [self.delegate multiplayerContainerView:self actionForSelectedPerson:self.personsDatas[sender.superview.tag]];
    }
}
//点击添加按钮
- (void)personAdd:(UIButton*)sender{
    //添加点击添加按钮时要显示全部
    self.isAllShows = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(multiplayerContainerViewActionForAddPerson:)]) {
        [self.delegate multiplayerContainerViewActionForAddPerson:self];
    }
}
//点击移除按钮
- (void)personRemoving:(UIButton*)sender{
    //添加点击移除按钮时要显示全部
    self.isAllShows = YES;
    self.isRemoving ^= YES;
}
//点击移除按钮
- (void)personRemove:(UIButton*)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(multiplayerContainerView:actionForRemovePerson:)]) {
        [self.delegate multiplayerContainerView:self actionForRemovePerson:self.personsDatas[sender.superview.tag]];
    }
}

@end
