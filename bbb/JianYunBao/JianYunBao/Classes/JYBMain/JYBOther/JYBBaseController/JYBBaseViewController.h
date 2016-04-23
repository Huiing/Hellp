//
//  JYBBaseViewController.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JYBNavigationBarButtonDirectionLeft,
    JYBNavigationBarButtonDirectionRight,
} JYBNavigationBarButtonDirection;

@protocol SuperNavBtnDelegate <NSObject>

@optional
- (void)navigationItemBtn:(UIButton *)btn clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface JYBBaseViewController : UIViewController <SuperNavBtnDelegate>

@property (nonatomic, copy) NSString *navigationTitle;
@property (nonatomic, strong) UIColor *backgroundColor;

- (instancetype)init;

- (void)setNavigationTitle:(NSString *)navigationTitle titleColor:(UIColor *)color;
- (void)addBackBarButtonItemOnNavigation:(NSString*)backItemImg tintColor:(UIColor *)color;
- (void)backBarBtnItemClick;
/*!
 *  @brief  给导航条添加按钮
 *
 *  @param imageName 背景图片名字
 *  @param title     标题
 *  @param color     文字颜色
 *  @param target    target
 *  @param action    action
 *  @param direction 方向，YES-->左 NO-->右
 */
- (void)addNavgationBarButtonWithImage:(NSString*)imageName
                                 title:(NSString*)title
                            titleColor:(UIColor*)color
                             addTarget:(id)target
                                action:(SEL)action
                             direction:(JYBNavigationBarButtonDirection)direction;

- (void)addNavgationBarButtonWithImage:(NSString *)imageName
                             addTarget:(id)target
                                action:(SEL)action
                             direction:(JYBNavigationBarButtonDirection)direction;

- (void)addNavgationBarButtonWithImage1:(NSString*)imageName1
                                 image2:(NSString*)imageName2
                                 title1:(NSString*)title1
                                 title2:(NSString*)title2
                            titleColor1:(UIColor*)color1
                            titleColor2:(UIColor*)color2
                              addTarget:(id)target
                                action1:(SEL)action1
                                action2:(SEL)action2
                              direction:(JYBNavigationBarButtonDirection)direction;

- (void)addNavgationBarButtonWithImage1:(NSString*)imageName1
                                 image2:(NSString*)imageName2
                              addTarget:(id)target
                                action1:(SEL)action1
                                action2:(SEL)action2
                              direction:(JYBNavigationBarButtonDirection)direction;

- (void)addNavgationBarButtonWithImage1:(NSString*)imageName1
                                 image2:(NSString*)imageName2
                                 image3:(NSString*)imageName3
                              addTarget:(id)target
                                action1:(SEL)action1
                                action2:(SEL)action2
                                action3:(SEL)action3
                              direction:(JYBNavigationBarButtonDirection)direction;

//图片不能置空
- (void)addNavgationBarButtonWithImageName:(NSString *)imgName otherTitles:(NSString *)titles, ...NS_REQUIRES_NIL_TERMINATION;

///键盘弹出和隐藏的回调
- (void)registerKeyboardNotification;
- (void)removeKeyboardNotification;

@property (nonatomic, copy) void(^keyboardWillShowBlock)(CGFloat keyboardHeight, NSTimeInterval animationDuration);

///keyboardHeight:0
@property (nonatomic, copy) void(^keyboardWillHideBlock)(CGFloat keyboardHeight, NSTimeInterval animationDuration);

///根据类名初始化跳转--push
- (void)pushNextController:(NSString *)aClassName hidesBottomBarWhenPushed:(BOOL)hide;
- (void)pushNextController:(NSString *)aClassName hidesBottomBarWhenPushed:(BOOL)hide complete:(void(^)(UIViewController *vCtrl))complete;

@end


