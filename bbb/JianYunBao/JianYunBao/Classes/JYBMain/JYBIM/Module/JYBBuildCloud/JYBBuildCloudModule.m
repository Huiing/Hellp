//
//  JYBBuildCloudModule.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBuildCloudModule.h"
#import "JYBBuildCloudEntity.h"

@implementation JYBBuildCloudModule

+ (instancetype)sharedInstance {
    static JYBBuildCloudModule * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[JYBBuildCloudModule alloc] init];
    });
    return _someCls;
}


//- (JYBBuildCloudEntity *)getBuildCloudEntity
//{
//    
//}

@end
