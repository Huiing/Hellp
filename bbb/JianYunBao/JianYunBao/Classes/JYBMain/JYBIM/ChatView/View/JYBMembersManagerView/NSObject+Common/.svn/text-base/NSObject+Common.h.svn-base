//
//  NSObject+Common.h
//  OAS
//
//  Created by C-147 on 13-1-18.
//
//

#import <Foundation/Foundation.h>
#import "NSString+Common.h"
#import "NSData+Common.h"
#import "NSDate+Common.h"

//---- Platform ----------------------------------------------------------------------------------------------

//Release屏蔽NSLog
#ifdef DEBUG

#else
#define NSLog(...) {};
#endif

//G.C.D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
//Device
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define MAINBOUNDWIDTH [UIScreen mainScreen].bounds.size.width
#define MAINBOUNDHEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *	@brief	获取IOS的版本号
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/**
 *	@brief	判断是否IOS7或之后的版本
 */
#define IOS7OrLater (IOS_VERSION >= 7.0)
/**
 *	@brief	判断是否是4英寸的高清屏
 */
#define DEVICE_R4 ([[UIScreen mainScreen] bounds].size.height > 481)

#define CRLF @"\r\n"
#define CRLFLength 2
//去掉ARC下NSSelectorFromString后performSelector警告的问题
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
//==== Platform ==============================================================================================

//---- NSObject ----------------------------------------------------------------------------------------------

//释放对象
#define ObjRelease(object) [object release]; object = nil
//给对象赋新值
#define ObjReplace(object,newObject) [object release]; object = [newObject retain]
//判断是否为空(nil 或 NSNull)
#define IsNull(object) [NSObject isNull:object]
//用0xRRGGBB格式取UIColor对象
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface NSObject (Common)

+(BOOL)isNull:(NSObject*)obj;
-(BOOL)isNSNull;

@end

//==== NSObject ==============================================================================================

//---- NSMutableDictionary -----------------------------------------------------------------------------------

#define MtDicSetValue(dic,key,value) if(value == nil){ [dic removeObjectForKey:key];}else{ dic[key] = value;}

//==== NSMutableDictionary ===================================================================================
