//
//  UITableView+Common.m
//  minaim
//
//  Created by mac on 13-12-5.
//  Copyright (c) 2013年 do1. All rights reserved.
//

#import "UITableView+Common.h"

@implementation UITableView (Common)

-(id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] allocWithZone:zone] init];
    return copy;
}

@end
