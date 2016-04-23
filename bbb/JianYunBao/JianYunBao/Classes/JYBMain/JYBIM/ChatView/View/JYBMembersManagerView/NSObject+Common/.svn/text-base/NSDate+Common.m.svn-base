//
//  NSDate+Common.m
//  Controls
//
//  Created by C-147 on 13-2-8.
//  Copyright (c) 2013年 C-147. All rights reserved.
//

#import "NSDate+Common.h"

//日期: 公共
@implementation NSDate (Common)

//通过年月日生成日期
+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *result = [gregorian dateFromComponents:components];
    return result;
}
+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    return [[self class] dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

@end

//日期: 字符串格式化
@implementation NSDate (StringFormat)

//获取时间字符串形式
- (NSString*)stringWithFormat:(NSString*)format{
    return [self stringWithFormat:format local:[NSLocale systemLocale]];
}
- (NSString*)stringWithFormat:(NSString*)format localeIdentifier:(NSString*)localeIdentifier{
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    NSString *string = [self stringWithFormat:format local:local];
    return string;
}
- (NSString*)stringWithFormat:(NSString*)format local:(NSLocale *)local{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = local;
    NSString *string = [formatter stringFromDate:self];
    return string;
}

//通过字符串生成日期
+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format{
    return [[self class] dateWithString:string format:format local:[NSLocale systemLocale]];
}
+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format localeIdentifier:(NSString*)localeIdentifier{
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    NSDate *date = [[self class] dateWithString:string format:format local:local];
    return date;
}
+ (NSDate*)dateWithString:(NSString*)string format:(NSString*)format local:(NSLocale*)local{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = local;
    NSDate *date = [formatter dateFromString:string];
    return date;
}

@end

//字符串: 日期格式化
@implementation NSString (DateFormat)

//将日期字符串转成另一种格式的日期字符串
- (NSString *)dateStringWithFormat:(NSString*)format targetFormat:(NSString*)targetFormat{
    return [self dateStringWithFormat:format locale:[NSLocale systemLocale] targetFormat:targetFormat];
}
- (NSString *)dateStringWithFormat:(NSString*)format localeIdentifier:(NSString*)localeIdentifier targetFormat:(NSString*)targetFormat{
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    NSString *dateString = [self dateStringWithFormat:format locale:local targetFormat:targetFormat];
    return dateString;
}
- (NSString *)dateStringWithFormat:(NSString*)format locale:(NSLocale*)locale targetFormat:(NSString*)targetFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = locale;
    NSDate *date = [formatter dateFromString:self];
    formatter.dateFormat = targetFormat;
    NSString *targetString = [formatter stringFromDate:date];
    return targetString;
}

@end
