//
//  BDReceiveWhiteboardMessageAPI.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDReceiveWhiteboardMessageAPI.h"
#import "JYBWhiteboardMessageEntity.h"


@implementation BDReceiveWhiteboardMessageAPI
{
    JYBIMMessageBodyType _messageBodyType;
}

- (instancetype)initWithWhiteboardMessageType:(JYBIMMessageBodyType)messageBodyType
{
    if (self = [super init]) {
        _messageBodyType = messageBodyType;
    }
    return self;
}

- (int)responseCommandID
{
    switch (_messageBodyType) {
        case JYBIMMessageBodyTypeText:
            return BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE;
            break;
        case JYBIMMessageBodyTypeAudio:
            return BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE;
            break;
        case JYBIMMessageBodyTypeImage:
            return BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE;
            break;
        case JYBIMMessageBodyTypeVideo:
            return BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE;
            break;
        default:
            return 0;
            break;
    }
}

- (BDUnreqeustAPIAnalysis)unrequestAnalysis
{
    BDUnreqeustAPIAnalysis analysis = (id)^(NSData *data, int commandID) {
        JYBIMMessage *message = [JYBIMMessage parseFromData:data commandID:commandID];
        JYBWhiteboardMessageEntity *messageEntity = [[JYBWhiteboardMessageEntity alloc] initWithMessage:message];
        return messageEntity;
    };
    return analysis;
}

@end
