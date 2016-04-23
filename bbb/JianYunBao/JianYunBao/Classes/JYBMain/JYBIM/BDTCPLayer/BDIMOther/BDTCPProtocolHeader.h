//
//  BDTCPProtocolHeader.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

//commandId
enum {
    
    BD_TCP_PROTOCOL_CODE_LOGIN               = 1000,//上线登录
    BD_TCP_PROTOCOL_CODE_LOGIN_RES           = 1001,//上线响应
    BD_TCP_PROTOCOL_CODE_INVALIDUSER         = 1002,//推送无效用户
    BD_TCP_PROTOCOL_CODE_RELOGIN             = 1003,//重新上线登录
    BD_TCP_PROTOCOL_CODE_KICOUT              = 1004,//挤下线通知`Kickout`
    BD_TCP_PROTOCOL_CODE_VERIFYTIME          = 1006,//校时
    BD_TCP_PROTOCOL_CODE_HEARTBEAT           = 1010,//心跳
    BD_TCP_PROTOCOL_CODE_NETWORKREACHABILITY = 1020,//网络性能测试
    
    /******************************企业白板(white board)相关功能码****************************/
    BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE  = 1100,//企业白板文本即时消息
    BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE = 1101,//企业白板音频即时消息
    BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE = 1102,//企业白板图片即时消息
    BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE = 1103,//企业白板视频即时消息
    BD_TCP_PROTOCOL_CODE_WHITEBOARD_FILE_MESSAGE  = 1104,//企业白板文件即时消息
    
    /******************************群组(chat group)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_CHATGROUP_CREATE = 1110,//创建聊天群组
    BD_TCP_PROTOCOL_CODE_CHATGROUP_UPDATE = 1111,//更新聊天群组
    BD_TCP_PROTOCOL_CODE_CHATGROUP_DELETE = 1112,//删除聊天群组
    
    BD_TCP_PROTOCOL_CODE_CHATGROUP_TEXT_MESSAGE  = 1120,//聊天群组文本即时消息
    BD_TCP_PROTOCOL_CODE_CHATGROUP_AUDIO_MESSAGE = 1121,//聊天群组音频即时消息
    BD_TCP_PROTOCOL_CODE_CHATGROUP_IMAGE_MESSAGE = 1122,//聊天群组图片即时消息
    BD_TCP_PROTOCOL_CODE_CHATGROUP_VIDEO_MESSAGE = 1123,//聊天群组视频即时消息
    BD_TCP_PROTOCOL_CODE_CHATGROUP_FILE_MESSAGE  = 1124,//聊天群组文件即时消息
    
    /******************************单聊(chat single)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_CHATSINGLE_TEXT_MESSAGE  = 1130,//单聊文本即时消息
    BD_TCP_PROTOCOL_CODE_CHATSINGLE_AUDIO_MESSAGE = 1131,//单聊音频即时消息
    BD_TCP_PROTOCOL_CODE_CHATSINGLE_IMAGE_MESSAGE = 1132,//单聊图片即时消息
    BD_TCP_PROTOCOL_CODE_CHATSINGLE_VIDEO_MESSAGE = 1133,//单聊视频即时消息
    BD_TCP_PROTOCOL_CODE_CHATSINGLE_FILE_MESSAGE  = 1134,//单聊文件即时消息
    
    /******************************工单(bill)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_BILL_CREATE = 1200,//创建工单
    BD_TCP_PROTOCOL_CODE_BILL_UPDATE = 1201,//更新工单
    BD_TCP_PROTOCOL_CODE_BILL_DELETE = 1202,//删除工单
    
    BD_TCP_PROTOCOL_CODE_BILL_STATUS_CONTINUE = 1204,//工单状态-继续
    BD_TCP_PROTOCOL_CODE_BILL_STATUS_PAUSE    = 1205,//工单状态-暂停
    BD_TCP_PROTOCOL_CODE_BILL_STATUS_FINISH   = 1206,//工单状态-完成
    BD_TCP_PROTOCOL_CODE_BILL_STATUS_CANCEL   = 1207,//工单状态-取消
    
    BD_TCP_PROTOCOL_CODE_BILL_COMMENT_TEXT_MESSAGE  = 1230,//工单评论文本即时消息
    BD_TCP_PROTOCOL_CODE_BILL_COMMENT_AUDIO_MESSAGE = 1231,//工单评论音频即时消息
    BD_TCP_PROTOCOL_CODE_BILL_COMMENT_IMAGE_MESSAGE = 1232,//工单评论图片即时消息
    BD_TCP_PROTOCOL_CODE_BILL_COMMENT_VIDEO_MESSAGE = 1233,//工单评论视频即时消息
    BD_TCP_PROTOCOL_CODE_BILL_COMMENT_FILE_MESSAGE  = 1234,//工单评论文件即时消息
    
    BD_TCP_PROTOCOL_CODE_BILL_RESULT_TEXT_MESSAGE  = 1235,//工单执行结果文本即时消息
    BD_TCP_PROTOCOL_CODE_BILL_RESULT_AUDIO_MESSAGE = 1236,//工单执行结果音频即时消息
    BD_TCP_PROTOCOL_CODE_BILL_RESULT_IMAGE_MESSAGE = 1237,//工单执行结果图片即时消息
    BD_TCP_PROTOCOL_CODE_BILL_RESULT_VIDEO_MESSAGE = 1238,//工单执行结果视频即时消息
    BD_TCP_PROTOCOL_CODE_BILL_RESULT_FILE_MESSAGE  = 1239,//工单执行结果文件即时消息
    
    /******************************质量检查(quality check)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_CREATE = 1300,//创建质量检查单
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_UPDATE = 1301,//更新质量检查单
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_DELETE = 1302,//删除质量检查单
    
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_CONTINUE  = 1304,//质量检查单状态-继续
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_PAUSE     = 1305,//质量检查单状态-暂停
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_FINISH    = 1306,//质量检查单状态-完成
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_CANCEL    = 1307,//质量检查单状态-取消
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_QUALIFY   = 1308,//质量检查单状态-合格
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_UNQUALIFY = 1309,//质量检查单状态-不合格
    
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_TEXT_MESSAGE  = 1330,//质量检查单评论文本即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_AUDIO_MESSAGE = 1331,//质量检查单评论音频即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_IMAGE_MESSAGE = 1332,//质量检查单评论图片即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_VIDEO_MESSAGE = 1333,//质量检查单评论视频即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_FILE_MESSAGE  = 1334,//质量检查单评论文件即时消息
    
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_TEXT_MESSAGE  = 1335,//质量检查单执行结果文本即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_AUDIO_MESSAGE = 1336,//质量检查单执行结果音频即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_IMAGE_MESSAGE = 1337,//质量检查单执行结果图片即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_VIDEO_MESSAGE = 1338,//质量检查单执行结果视频即时消息
    BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_FILE_MESSAGE  = 1339,//质量检查单执行结果文件即时消息
    
    /******************************安全检查(safety check)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_CREATE = 1400,//创建安全检查单
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_UPDATE = 1401,//更新安全检查单
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_DELETE = 1402,//删除安全检查单
    
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_CONTINUE  = 1404,//安全检查单状态-继续
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_PAUSE     = 1405,//安全检查单状态-暂停
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_FINISH    = 1406,//安全检查单状态-完成
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_CANCEL    = 1407,//安全检查单状态-取消
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_QUALIFY   = 1408,//安全检查单状态-合格
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_UNQUALIFY = 1409,//安全检查单状态-不合格
    
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_TEXT_MESSAGE  = 1430,//安全检查单评论文本即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_AUDIO_MESSAGE = 1431,//安全检查单评论音频即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_IMAGE_MESSAGE = 1432,//安全检查单评论图片即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_VIDEO_MESSAGE = 1433,//安全检查单评论视频即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_FILE_MESSAGE  = 1434,//安全检查单评论文件即时消息
    
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_TEXT_MESSAGE  = 1435,//安全检查单执行结果文本即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_AUDIO_MESSAGE = 1436,//安全检查单执行结果音频即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_IMAGE_MESSAGE = 1437,//安全检查单执行结果图片即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_VIDEO_MESSAGE = 1438,//安全检查单执行结果视频即时消息
    BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_FILE_MESSAGE  = 1439,//安全检查单执行结果文件即时消息
    
    
    /******************************日常巡查(daily inspection)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_DAILYINSPECT_CREATE = 1500,//创建日常巡查
    
    BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_TEXT_MESSAGE  = 1510,//日常巡查单执行结果文本即时消息
    BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_AUDIO_MESSAGE = 1511,//日常巡查单执行结果音频即时消息
    BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_IMAGE_MESSAGE = 1512,//日常巡查单执行结果图片即时消息
    BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_VIDEO_MESSAGE = 1513,//日常巡查单执行结果视频即时消息
    BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_FILE_MESSAGE  = 1514,//日常巡查单执行结果文件即时消息
    
    /******************************公告(notice)相关功能码******************************/
    BD_TCP_PROTOCOL_CODE_NOTICE_CREATE = 2100,//创建通知公告
    
    BD_TCP_PROTOCOL_CODE_NOTICE_COMMENT_TEXT = 2110,//通知公告文本评论
    
    /******************************其他相关功能码******************************/
    
    BD_TCP_PROTOCOL_CODE_WARNING_MESSAGE = 2200,//预警消息
    BD_TCP_PROTOCOL_CODE_WORKFLOW_MESSAGE = 2300,//工作流待办信息
    
    
    /**********************************************************************************/
    /*
     * NOTE:
        -增加单点登录、文件传输、预警消息、工作流待办信息
     
     
     */
    
};

@interface BDTCPProtocolHeader : NSObject

@property (nonatomic, assign) UInt16 fps;//帧头
@property (nonatomic, assign) UInt16 fpsl;//帧长
@property (nonatomic, assign) UInt16 version;//协议版本
@property (nonatomic, assign) BDSTime sTime;//BCD时间
@property (nonatomic, assign) UInt16 subcontract;//分包表示//0000 0000
@property (nonatomic, assign) UInt16 commandId;//功能码

@end
