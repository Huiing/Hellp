//
//  JYBSelectFriendViewController.h
//  JianYunBao
//
//  Created by faith on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

@protocol JYBSelectFriendViewControllerDelegate <NSObject>

- (void)selectedFriendWithItems:(NSArray *)friends;

@end

@interface JYBSelectFriendViewController : JYBBaseViewController

@property (strong, nonatomic) NSMutableArray * selectedMembersIds;//已选人员
@property (assign, nonatomic) BOOL isFromCreatGroup;//是否来自建群
@property (assign, nonatomic) BOOL isFromAddPerson;//是否来自加人
@property (assign, nonatomic) id <JYBSelectFriendViewControllerDelegate> delegate;

@end
