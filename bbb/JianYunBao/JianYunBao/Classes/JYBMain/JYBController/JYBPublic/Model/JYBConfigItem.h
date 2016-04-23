//
//  JYBConfigItem.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBConfigItem : NSObject

/**是否定位数据产生地*/
@property (nonatomic, copy) NSString *isLocData;
/***/
@property (nonatomic, copy) NSString *androidAppSize;
/***/
@property (nonatomic, copy) NSString *iphoneDownLoad;
/**建云宝系统Http URL*/
@property (nonatomic, copy) NSString *bcHttpUrl;
/**是否自动播放语音*/
@property (nonatomic, copy) NSString *isAutoPlayAudio;
/***/
@property (nonatomic, copy) NSString *xtglhtUrl;
/***/
@property (nonatomic, copy) NSString *iphoneAppSize;
/***/
@property (nonatomic, copy) NSString *androidVersionCode;
/**服务端是否正在维护*/
@property (nonatomic, copy) NSString *isServerStop;
/**九宫格功能权限*/
@property (nonatomic, copy) NSString *enable;
/**ERP根路径*/
@property (nonatomic, copy) NSString *erpRootUrl;
/***/
@property (nonatomic, copy) NSString *androidDownLoad;
/***/
@property (nonatomic, copy) NSString *compName;
/**是否强制升级*/
@property (nonatomic, copy) NSString *isForceUpdate;
/**ERP系统Http URL*/
@property (nonatomic, copy) NSString *erpHttpUrl;
/**企业号*/
@property (nonatomic, copy) NSString *enterpriseCode;
/**建云宝系统TCP URL*/
@property (nonatomic, copy) NSString *bcTcpUrl;
/**消息,失败时，说明失败原因*/
@property (nonatomic, copy) NSString *message;
/**预计维护结束时刻*/
@property (nonatomic, copy) NSString *stopOverTime;
/**建云宝文件系统Http URL*/
@property (nonatomic, copy) NSString *bcfHttpUrl;
/**是否成功,成功为true,失败为false*/
@property (nonatomic, copy) NSString *result;
/***/
@property (nonatomic, copy) NSString *iphoneVersion;
/***/
@property (nonatomic, copy) NSString *autoid;

@end
