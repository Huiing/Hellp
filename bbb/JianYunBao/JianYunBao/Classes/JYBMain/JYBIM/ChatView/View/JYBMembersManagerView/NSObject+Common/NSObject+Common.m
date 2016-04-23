//
//  NSObject+Common.m
//  OAS
//
//  Created by C-147 on 13-1-18.
//
//

#import "NSObject+Common.h"

//---- NSObject ----------------------------------------------------------------------------------------------

@implementation NSObject (Common)

+(BOOL)isNull:(NSObject*)obj{
    if (obj == nil) {
        return YES;
    }
    return [obj isNSNull];
}
-(BOOL)isNSNull{
    return [self isKindOfClass:[NSNull class]];
}

@end

//==== NSObject ==============================================================================================