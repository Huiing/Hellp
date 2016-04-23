//
//  BDIMHeader.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//


#ifndef BDIMHeader_h
#define BDIMHeader_h

#import "BDClientStateMaintenanceManager.h"
#import "JYBIMConstant.h"
#import "BDNotification.h"
#import "BDConfig.h"
#import "NSDate+BDAddition.h"
#import "RuntimeStatus.h"
#import "JYBBuildCloudEntity.h"
#import "DDReachability.h"
#import "Emoji.h"
#import "EMErrorDefs.h"
#import "BDIChatManagerDefs.h"
#import "NSDictionary+Safe.h"
#import "NSDictionary+Accessors.h"

///协议版本号
#define TCP_Protocol_Version 1

#define JYBError(args) [NSError errorWithDomain:args code:-1001 userInfo:@{@"error":args}]

#define JYBErpHttpUrl(args) [[RuntimeStatus sharedInstance].buildCloudEntity.erpHttpUrl stringByAppendingString:bd_isValidKey(args)?args:@""]
#define JYBBCHttpUrl(args) [[RuntimeStatus sharedInstance].buildCloudEntity.bcHttpUrl stringByAppendingString: bd_isValidKey(args)?args:@""]
#define JYBBcfHttpUrl(args) [[RuntimeStatus sharedInstance].buildCloudEntity.bcfHttpUrl stringByAppendingString: bd_isValidKey(args)?args:@""]
//图片网址拼接宏
#define JYBErpRootUrl(args) [[RuntimeStatus sharedInstance].buildCloudEntity.erpRootUrl stringByAppendingString:bd_isValidKey(args)?args:@""]

///即时通讯用的图片网址拼接宏
#define JYBImageUrl(args) JYBBcfHttpUrl(args)

#endif /* BDIMHeader_h */
