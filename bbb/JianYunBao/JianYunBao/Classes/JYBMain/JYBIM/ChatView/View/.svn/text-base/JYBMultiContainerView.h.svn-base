//
//  JYBMultiContainerView.h
//  JianYunBao
//
//  Created by 正 on 16/3/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYBMultiContainerViewDelegate;

@interface JYBMultiContainerView : UIView{
    BOOL _isAddButtonShowing;
}

@property (nonatomic, readonly) UIView *container;
@property (nonatomic, readonly) UIView *showMoreView;
@property (nonatomic, readonly) UIButton *showMoreButton;
@property (nonatomic, readonly) NSMutableArray *personsDatas;
@property (nonatomic, weak) id<JYBMultiContainerViewDelegate> delegate;

/**
 *	@brief	是否全部人员都显示了
 */
@property (nonatomic, assign) BOOL isAllShows;
/**
 *	@brief	是否能添加人员
 */
@property (nonatomic, assign) BOOL isAddable;
/**
 *	@brief	是否能添加人员
 */
@property (nonatomic, readonly) BOOL isAddButtonShowing;
/**
 *	@brief	是否能移除人员
 */
@property (nonatomic, assign) BOOL isRemoveable;
/**
 *	@brief	是否正在移除
 */
@property (nonatomic, assign) BOOL isRemoving;

/**
 *添加一组人
 */
- (void)addPersons:(NSArray*)persons;
/**
 *添加一组人
 */
- (void)addPersons:(NSArray*)persons withAnimated:(BOOL)animated;
/**
 *添加一个人
 */
- (void)addPerson:(NSDictionary*)person;
/**
 *添加一个人
 */
- (void)addPerson:(NSDictionary*)person withAnimated:(BOOL)animated;

/**
 *	@brief	移除一个人
 */
- (void)removePerson:(NSDictionary*)person;

/**
 *	@brief	移除一个人
 */
- (void)removePerson:(NSDictionary*)person withAnimated:(BOOL)animated;
/**
 *	@brief	清除数据
 */
- (void)removeAllPersons;
/**
 *	@brief	清除数据
 */
- (void)removeAllPersonsWithAnimated:(BOOL)animated;

@end

@protocol JYBMultiContainerViewDelegate <NSObject>
@optional
- (void)multiplayerContainerView:(JYBMultiContainerView*)multiplayerContainerView  actionForSelectedPerson:(NSDictionary*)person;
- (void)multiplayerContainerViewActionForAddPerson:(JYBMultiContainerView*)multiplayerContainerView;


- (void)multiplayerContainerView:(JYBMultiContainerView*)multiplayerContainerView  actionForRemovePerson:(NSDictionary*)person;

@end
