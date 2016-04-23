//
//  BDIChatManagerDefs.h
//  BDIChat
//  ChatManager相关宏定义
//  Created by 冰点 on 16/3/9.
//  Copyright © 2016年 冰点. All rights reserved.
//

#ifndef BDIChatManagerDefs_h
#define BDIChatManagerDefs_h

///聊天类型
typedef NS_ENUM(NSUInteger, JYBIMMessageBodyType) {
    JYBIMMessageBodyTypeText = 0,
    JYBIMMessageBodyTypeAudio,
    JYBIMMessageBodyTypeImage,
    JYBIMMessageBodyTypeVideo,
    JYBIMMessageBodyTypeFile,
    JYBIMMessageBodyTypeNone,//其他类型
};

///会话类型
typedef NS_ENUM(NSUInteger, JYBConversationType) {
    JYBConversationTypeWhiteboard = 0,
    
    JYBConversationTypeGroup,
    JYBConversationTypeSingle,
    
    JYBConversationTypeBillComment,
    JYBConversationTypeBillResult,
    JYBConversationTypeQualityComment,
    JYBConversationTypeQualityResult,
    JYBConversationTypeSafetyComment,
    JYBConversationTypeSafetyResult,
    
    JYBConversationTypeDaily,
    
    JYBConversationTypeNoticeComment,
};

///消息类型
typedef NS_ENUM(NSUInteger, JYBIMMessageType) {
    JYBIMMessageTypeWhiteboard,
    
    JYBIMMessageTypeGroup,
    JYBIMMessageTypeSingle,
    
    JYBIMMessageTypeBillComment,
    JYBIMMessageTypeBillResult,
    
    JYBIMMessageTypeQualityComment,
    JYBIMMessageTypeQualityResult,
    
    JYBIMMessageTypeSafetyComment,
    JYBIMMessageTypeSafetyResult,
    
    JYBIMMessageTypeDaily,
    
    JYBIMMessageTypeNoticeComment,
};

// 消息的行为状态
// 组-群、工单、质量检测单、安全检测单
// 创建、更新、删除、继续、暂停、完成、取消、合格、不合格
typedef NS_ENUM(NSUInteger, JYBMessageActionStatus) {
    
    JYBMessageActionStatusGroupCreate = 0,
    JYBMessageActionStatusGroupUpdate,
    JYBMessageActionStatusGroupDelete,
    
    JYBMessageActionStatusBillCreate,
    JYBMessageActionStatusBillUpdate,
    JYBMessageActionStatusBillDelete,
    JYBMessageActionStatusBillContinue,
    JYBMessageActionStatusBillPause,
    JYBMessageActionStatusBillFinished,
    JYBMessageActionStatusBillCancel,
    
    
    JYBMessageActionStatusQualityCreate,
    JYBMessageActionStatusQualityUpdate,
    JYBMessageActionStatusQualityDelete,
    JYBMessageActionStatusQualityContinue,
    JYBMessageActionStatusQualityPause,
    JYBMessageActionStatusQualityFinished,
    JYBMessageActionStatusQualityCancel,
    JYBMessageActionStatusQualityQualify,
    JYBMessageActionStatusQualityUnQualify,//不合格
    
    
    JYBMessageActionStatusSafetyCreate,
    JYBMessageActionStatusSafetyUpdate,
    JYBMessageActionStatusSafetyDelete,
    JYBMessageActionStatusSafetyContinue,
    JYBMessageActionStatusSafetyPause,
    JYBMessageActionStatusSafetyFinished,
    JYBMessageActionStatusSafetyCancel,
    JYBMessageActionStatusSafetyQualify,
    JYBMessageActionStatusSafetyUnQualify,
    
};


struct BDSTime {//日期时间结构体
    int16_t year;
    int16_t month;
    int16_t day;
    int16_t hour;
    int16_t min;
    int16_t sec;
};

//struct BDSTime {//日期时间结构体
//    int16_t year;
//    int8_t month;
//    int8_t day;
//    int8_t hour;
//    int8_t min;
//    int8_t sec;
//};


typedef struct BDSTime BDSTime;


typedef enum : NSUInteger {
    JYBBillTypeComment,
    JYBBillTypeNode,
} JYBBillType;








#endif /* BDIChatManagerDefs_h */
