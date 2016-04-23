//
//  BDAPIUnrequestScheduleProtocol.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^BDUnreqeustAPIAnalysis)(NSData *data, int commandID);

@protocol BDAPIUnrequestScheduleProtocol <NSObject>
@required

/**
 *  数据包中的commandID
 *
 *  @return commandID
 */
- (int)responseCommandID;

/**
 *  解析数据包
 *
 *  @return 解析数据包的block
 */
- (BDUnreqeustAPIAnalysis)unrequestAnalysis;

- (instancetype)initWithMessageCommandID:(int)commandID;

@end
