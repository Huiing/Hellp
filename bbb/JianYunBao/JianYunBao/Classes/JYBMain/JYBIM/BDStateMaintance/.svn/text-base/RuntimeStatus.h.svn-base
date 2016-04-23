//
//  RuntimeStatus.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDIChatManagerDefs.h"

@class JYBUserEntity, JYBBuildCloudEntity, JYBUserItem;
@interface RuntimeStatus : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) JYBUserEntity *userEntity;
@property (nonatomic, strong) JYBUserItem *userItem;

@property (nonatomic, strong) JYBBuildCloudEntity *buildCloudEntity;


- (NSString *)conversationForChatter:(NSString *)chatter conversationType:(JYBConversationType)type;

- (void)updateUserEntity:(JYBUserEntity *)user withBuildCloudEntity:(JYBBuildCloudEntity *)buildCloud;
- (void)updateData;

- (void)clearCache;
@end
