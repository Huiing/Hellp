//
//  NSDate+Common.h
//  Controls
//
//  Created by C-147 on 13-2-8.
//  Copyright (c) 2013年 C-147. All rights reserved.
//

#import <Foundation/Foundation.h>

//创建日期
#define DateMake(y,m,d) [NSDate dateWithYear:y month:m day:d]
#define DateTimeMake(y,m,d,h,m2,s) [NSDate dateWithYear:y month:m day:d hour:h minute:m2 second:s]
#define DateMakeStr(fm,dataStr) [NSDate dateWithString:dataStr format:fm]

//日期: 公共
@interface NSDate (Common)

//通过年月日生成日期
+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

//日期: 字符串格式化
@interface NSDate (StringFormat)

//获取时间字符串形式
- (NSString*)stringWithFormat:(NSString*)format;
- (NSString*)stringWithFormat:(NSString*)format localeIdentifier:(NSString*)localeIdentifier;
- (NSString*)stringWithFormat:(NSString*)format local:(NSLocale*)local;

//通过字符串生成日期
+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format;
+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format localeIdentifier:(NSString*)localeIdentifier;
+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format local:(NSLocale*)local;

@end

//字符串: 日期格式化
@interface NSString (DateFormat)

//将日期字符串转成另一种格式的日期字符串
- (NSString *)dateStringWithFormat:(NSString*)format targetFormat:(NSString*)targetFormat;
- (NSString *)dateStringWithFormat:(NSString*)format localeIdentifier:(NSString*)localeIdentifier targetFormat:(NSString*)targetFormat;
- (NSString *)dateStringWithFormat:(NSString*)format locale:(NSLocale*)locale targetFormat:(NSString*)targetFormat;

@end