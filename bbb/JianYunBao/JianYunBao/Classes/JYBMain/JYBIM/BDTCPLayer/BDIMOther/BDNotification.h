//
//  BDNotification.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDNotification : NSObject

+ (void)postNotification:(NSString*)notification userInfo:(NSDictionary*)userInfo object:(id)object;

@end
