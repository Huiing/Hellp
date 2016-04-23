//
//  JYBBaseViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

@interface JYBBaseViewController ()

@end

@implementation JYBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundColor = JYBBackgroundColor;
    [self addBackBarButtonItemOnNavigation:@"更多选择" tintColor:JYBWhiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

//MARK: setter & getter
- (void)setNavigationTitle:(NSString *)navigationTitle
{
    _navigationTitle = navigationTitle;
    self.navigationItem.title = navigationTitle;
//    CGSize size = [navigationTitle sizeWithFont:NPFont(17) maxSize:CGSizeMake(MAXFLOAT, 20)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 20)];
//    label.font = NPFont(17);
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = navigationTitle;
//    self.navigationItem.titleView = label;
}

- (void)setNavigationTitle:(NSString *)navigationTitle titleColor:(UIColor *)color
{
    _navigationTitle = navigationTitle;
//    CGSize size = [navigationTitle sizeWithFont:NPFont(17) maxSize:CGSizeMake(MAXFLOAT, 20)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 20)];
//    label.font = NPFont(17);
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = navigationTitle;
//    label.textColor = color;
//    self.navigationItem.titleView = label;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.view.backgroundColor = backgroundColor;
}

- (void)addBackBarButtonItemOnNavigation:(NSString*)backItemImg tintColor:(UIColor *)color
{
    if (self.navigationController.viewControllers.count>1) {
        //        UIButton * backBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [backBarItem setFrame:CGRectMake(0, 0, 10, 19)];
        //        [backBarItem setImage:[UIImage imageNamed:backItemImg]
        //                     forState:UIControlStateNormal];
        //        [backBarItem addTarget:self
        //                        action:@selector(backBarBtnItemClick)
        //              forControlEvents:UIControlEventTouchUpInside];
        //        UIButton * hiddenItem = [UIButton buttonWithType:UIButtonTypeContactAdd];
        //        hiddenItem.hidden = YES;
        //        UIBarButtonItem*leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backBarItem];
        //        UIBarButtonItem * hiddenBarItem = [[UIBarButtonItem alloc] initWithCustomView:hiddenItem];
        //        hiddenBarItem = nil;
        //        UIBarButtonItem * fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
        //                                                                                  target:self
        //                                                                                  action:nil];
        //        fixItem.width = 10;
        //        self.navigationItem.leftBarButtonItems  = @[leftBarButtonItem];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:backItemImg] style:UIBarButtonItemStylePlain target:self action:@selector(backBarBtnItemClick)];
        self.navigationItem.leftBarButtonItem = backItem;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        backItem.tintColor = color;
    }
}

- (void)addNavgationBarButtonWithImage:(NSString*)imageName
                                 title:(NSString*)title
                            titleColor:(UIColor*)color
                             addTarget:(id)target
                                action:(SEL)action
                             direction:(JYBNavigationBarButtonDirection)direction
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.tintColor = JYBWhiteColor;
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    if ([title length]) {
        CGSize size = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(17*10, 30)];
        CGPoint origin = CGPointMake(0, 0);
        button.frame = (CGRect){origin, size};
    } else {
        button.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
    }
    
    if ([imageName length]) {
        UIImage *image = [UIImage imageNamed:imageName];
#define MAX_NAV_SIZE 30
        CGSize retSize = image.size;
        if (retSize.width > retSize.height) {
            CGFloat height =  MAX_NAV_SIZE / retSize.width  *  retSize.height;
            retSize.height = height;
            retSize.width = MAX_NAV_SIZE;
        }else {
            CGFloat width = MAX_NAV_SIZE / retSize.height * retSize.width;
            retSize.width = width;
            retSize.height = MAX_NAV_SIZE;
        }
        [button setImage:image forState:UIControlStateNormal];
        button.size = retSize;
        [button setImage:image forState:UIControlStateNormal];
        
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //创建Item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    item.tintColor = JYBMainColor;
    
    if (direction == JYBNavigationBarButtonDirectionLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addNavgationBarButtonWithImage:(NSString *)imageName
                             addTarget:(id)target
                                action:(SEL)action
                             direction:(JYBNavigationBarButtonDirection)direction;
{
    [self addNavgationBarButtonWithImage:imageName title:nil titleColor:nil addTarget:target action:action direction:direction];
}

- (void)addNavgationBarButtonWithImage1:(NSString*)imageName1
                                 image2:(NSString*)imageName2
                                 title1:(NSString*)title1
                                 title2:(NSString*)title2
                            titleColor1:(UIColor*)color1
                            titleColor2:(UIColor*)color2
                             addTarget:(id)target
                                action1:(SEL)action1
                                action2:(SEL)action2
                             direction:(JYBNavigationBarButtonDirection)direction
{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button1 setTitle:title1 forState:UIControlStateNormal];
    [button1 setTitleColor:color1 forState:UIControlStateNormal];
    button1.tintColor = JYBWhiteColor;
    button1.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    if ([title1 length]) {
        CGSize size = [title1 sizeWithFont:button1.titleLabel.font maxSize:CGSizeMake(17*10, 30)];
        CGPoint origin = CGPointMake(0, 0);
        button1.frame = (CGRect){origin, size};
    } else {
        button1.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
    }
    
    if ([imageName1 length]) {
        UIImage *image = [UIImage imageNamed:imageName1];
        [button1 setImage:image forState:UIControlStateNormal];
        
    }
    [button1 addTarget:target action:action1 forControlEvents:UIControlEventTouchUpInside];
    
    //创建Item
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    item1.tintColor = JYBMainColor;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button2 setTitle:title2 forState:UIControlStateNormal];
    [button2 setTitleColor:color2 forState:UIControlStateNormal];
    button2.tintColor = JYBWhiteColor;
    button2.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    if ([title2 length]) {
        CGSize size = [title2 sizeWithFont:button2.titleLabel.font maxSize:CGSizeMake(17*10, 30)];
        CGPoint origin = CGPointMake(0, 0);
        button2.frame = (CGRect){origin, size};
    } else {
        button2.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
    }
    
    if ([imageName2 length]) {
        UIImage *image = [UIImage imageNamed:imageName2];
        [button2 setImage:image forState:UIControlStateNormal];
        
    }
    [button2 addTarget:target action:action2 forControlEvents:UIControlEventTouchUpInside];
    
    //创建Item
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    item2.tintColor = JYBMainColor;
    
    NSArray *arr = [[NSArray alloc] initWithObjects:item1,item2, nil];
    if (direction == JYBNavigationBarButtonDirectionLeft) {
        self.navigationItem.leftBarButtonItems = arr;
    } else {
        self.navigationItem.rightBarButtonItems = arr;
    }
}

- (void)addNavgationBarButtonWithImage1:(NSString*)imageName1
                                 image2:(NSString*)imageName2
                              addTarget:(id)target
                                action1:(SEL)action1
                                action2:(SEL)action2
                              direction:(JYBNavigationBarButtonDirection)direction{
    [self addNavgationBarButtonWithImage1:imageName1 image2:imageName2 title1:nil title2:nil titleColor1:nil titleColor2:nil addTarget:target action1:action1 action2:action2 direction:direction];
}

- (void)addNavgationBarButtonWithImage1:(NSString*)imageName1
                                 image2:(NSString*)imageName2
                                 image3:(NSString*)imageName3
                              addTarget:(id)target
                                action1:(SEL)action1
                                action2:(SEL)action2
                                action3:(SEL)action3
                              direction:(JYBNavigationBarButtonDirection)direction{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button1.tintColor = JYBWhiteColor;
    button1.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
    
    if ([imageName1 length]) {
        UIImage *image = [UIImage imageNamed:imageName1];
        [button1 setImage:image forState:UIControlStateNormal];
    }
    [button1 addTarget:target action:action1 forControlEvents:UIControlEventTouchUpInside];
    
    //创建Item
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    item1.tintColor = JYBMainColor;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.tintColor = JYBWhiteColor;
    button2.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
    if ([imageName2 length]) {
        UIImage *image = [UIImage imageNamed:imageName2];
        [button2 setImage:image forState:UIControlStateNormal];
        
    }
    [button2 addTarget:target action:action2 forControlEvents:UIControlEventTouchUpInside];
    //创建Item
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    item2.tintColor = JYBMainColor;
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.tintColor = JYBWhiteColor;
    button3.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
    if ([imageName3 length]) {
        UIImage *image = [UIImage imageNamed:imageName3];
        [button3 setImage:image forState:UIControlStateNormal];
        
    }
    [button3 addTarget:target action:action3 forControlEvents:UIControlEventTouchUpInside];
    //创建Item
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:button3];
    item3.tintColor = JYBMainColor;
    
    NSArray *arr = [[NSArray alloc] initWithObjects:item1,item2,item3, nil];
    if (direction == JYBNavigationBarButtonDirectionLeft) {
        self.navigationItem.leftBarButtonItems = arr;
    } else {
        self.navigationItem.rightBarButtonItems = arr;
    }
    
}

- (void)addNavgationBarButtonWithImageName:(NSString *)imgName otherTitles:(NSString *)titles, ...
{
    NSMutableArray <NSString *>*argsArray = [NSMutableArray array];
    [argsArray addObject:imgName];
    NSString* curStr;
    va_list list;
    if(titles)
    {
        [argsArray addObject:titles];
        va_start(list, titles);
        while ((curStr= va_arg(list, NSString*))){
            [argsArray addObject:curStr];
        }
        va_end(list);
    }
    
    NSMutableArray *btns = [NSMutableArray array];
    [argsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitleColor:JYBWhiteColor forState:UIControlStateNormal];
        button.tintColor = JYBWhiteColor;
        button.titleLabel.font = JYBFont(16.0);
        if (idx) {
            [button setTitle:obj forState:UIControlStateNormal];
            if ([obj length]) {
                CGSize size = [obj sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(17*10, 30)];
                CGPoint origin = CGPointMake(0, 0);
                button.frame = (CGRect){origin, size};
            } else {
                button.frame = CGRectMake(0, 0, Compose_Scale(20), Compose_Scale(30));
            }
        } else {
            if ([obj length]) {
#define MAX_NAV_SIZE 20
                UIImage *image = [UIImage imageNamed:obj];
                CGSize retSize = image.size;
                if (retSize.width > retSize.height) {
                    CGFloat height =  MAX_NAV_SIZE / retSize.width  *  retSize.height;
                    retSize.height = height;
                    retSize.width = MAX_NAV_SIZE;
                }else {
                    CGFloat width = MAX_NAV_SIZE / retSize.height * retSize.width;
                    retSize.width = width;
                    retSize.height = MAX_NAV_SIZE;
                }
                [button setImage:image forState:UIControlStateNormal];
                button.size = retSize;
            }
        }
        button.tag = 100000+idx;
        [button addTarget:self action:@selector(didSelectedNavRightButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        item.tintColor = JYBMainColor;
        [btns addObject:item];
    }];
    NSEnumerator *enumerator = [btns reverseObjectEnumerator];
    id obj;
    NSMutableArray *arr = [NSMutableArray array];
    while ((obj = [enumerator nextObject]) != nil) {
        [arr addObject:obj];
    }
    self.navigationItem.rightBarButtonItems = arr;
}

//MARK: loadData

//MARK: Action

- (void)didSelectedNavRightButton:(UIButton *)button
{
    [(id<SuperNavBtnDelegate>)self navigationItemBtn:button clickedButtonAtIndex:button.tag - 100000];
}

- (void)backBarBtnItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//MARK: delegate

//MARK: Other
- (void)registerKeyboardNotification
{
    //增加监听，当键盘高度改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillChangeFrame:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    if (keyboardRect.origin.y >= self.view.height) {
        keyboardHeight = 0;
    }
    
    NSNumber *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    if (_keyboardWillShowBlock) {
        _keyboardWillShowBlock(keyboardHeight, [animationDuration doubleValue]);
    }
}


- (void)pushNextController:(NSString *)aClassName hidesBottomBarWhenPushed:(BOOL)hide
{
    [self pushNextController:aClassName hidesBottomBarWhenPushed:hide complete:nil];
}

- (void)pushNextController:(NSString *)aClassName hidesBottomBarWhenPushed:(BOOL)hide complete:(void(^)(UIViewController *vCtrl))complete
{
    UIViewController *viewController = [[NSClassFromString(aClassName) alloc] init];
    viewController.hidesBottomBarWhenPushed = hide;
    
    if (complete) {
        complete(viewController);
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

