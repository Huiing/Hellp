//
//  JYBIMGetWhiteboardMessageApi.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

@interface JYBIMGetWhiteboardMessageApi : YTKRequest

///获取企业白板历史消息
- (instancetype)initGetWhiteboardMessageWithLastMsgId:(NSString *)lastMsgId;

@end
