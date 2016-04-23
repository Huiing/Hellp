//
//  JYBSyncIChatGroupApi.h
//  JianYunBao
//  群组、讨论组同步接口
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

typedef enum : NSUInteger {
    JYBIChatTypeGroup,
    JYBIChatTypeGroupTopic,
} JYBIChatType;

@interface JYBSyncIChatGroupApi : YTKRequest

/*!
 *  @author 冰点, 16-03-15 14:03:14
 *
 *  @brief  群组、讨论组同步接口
 *
 *  @param type      同步类型
 *  @param groupName 组Title
 *  @param startDt   开始时间
 *  @param endDt     结束时间
 *  @param page      页数
 *
 *  @return 同步接口
 */
- (instancetype)initSyncIChatGroupWithType:(JYBIChatType)type groupName:(NSString *)groupName startDt:(NSString *)startDt endDt:(NSString *)endDt page:(NSInteger)page;

@end
