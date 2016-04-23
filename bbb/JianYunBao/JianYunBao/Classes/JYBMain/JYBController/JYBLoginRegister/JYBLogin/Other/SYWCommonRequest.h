//
//  SYWCommonRequest.h
//  GuangHuaSocialCircle
//
//  Created by 宋亚伟 on 15/9/8.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "YTKRequest.h"

@interface SYWCommonRequest : YTKRequest

/**	请求链接*/
@property (nonatomic, copy) NSString *ReqURL;

/**
 * 请求参数字典
 */
@property (nonatomic, strong) NSDictionary *ReqDictionary;

@end
