//
//  BDNotification.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDNotification.h"

@implementation BDNotification

+ (void)postNotification:(NSString*)notification userInfo:(NSDictionary*)userInfo object:(id)object
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object userInfo:userInfo];
    });
}

@end
