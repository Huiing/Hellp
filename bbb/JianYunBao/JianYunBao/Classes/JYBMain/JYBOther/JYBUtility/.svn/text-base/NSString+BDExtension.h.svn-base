//
//  NSString+BDExtension.h
//  冰点
//
//  Created by 冰点 on 15/8/24.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EmojiClass : NSObject

@property (nonatomic, assign, getter=isEmoji) BOOL emoji;//是否为表情
@property (nonatomic, assign) NSRange substringRange;
@end
@interface NSString (BDExtension)

///计算字符串的大小
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

///禁止表情输入
+ (BOOL)isContainsEmoji:(NSString *)string;
+ (EmojiClass*)isTextContainsEmoji:(NSString *)string;
- (NSString *)URLEncodedString;
+ (NSString*)objToJson:(id )obj;
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
@end

