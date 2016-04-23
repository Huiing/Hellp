//
//  JYBUserItem.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBUserItem : NSObject

/**用户id*/
@property (nonatomic, copy) NSString *userId;
/**性别*/
@property (nonatomic, copy) NSString *sex;
/**所在单位*/
@property (nonatomic, copy) NSString *company;
/**用户名*/
@property (nonatomic, copy) NSString *userName;
/**手机号*/
@property (nonatomic, copy) NSString *phoneNum;
/**头像目录ID，用来修改头像使用，使用附件上传接口*/
@property (nonatomic, copy) NSString *iconPathId;
/**所在部门*/
@property (nonatomic, copy) NSString *department;
/**邮箱*/
@property (nonatomic, copy) NSString *email;
/**姓名*/
@property (nonatomic, copy) NSString *name;
/**头像地址*/
@property (nonatomic, copy) NSString *iconPaths;
/**失败时，说明失败原因*/
@property (nonatomic, copy) NSString *message;
/**是否成功，成功为true*/
@property (nonatomic, copy) NSString *result;

@end
