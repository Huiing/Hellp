//
//  JYBIMSendNoticeMessageApi.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/17.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

@interface JYBIMSendNoticeMessageApi : YTKRequest

//@brief required
@property (nonatomic, copy  ) NSString  *msg;
//@property (nonatomic, assign) NSInteger duration;
//@property (nonatomic, strong) NSData    *file;
@property (nonatomic, assign) JYBIMMessageBodyType type;

- (instancetype)initNoticeApiWithEnterpriseCode:(NSString *)enterpriseCode
                                             userName:(NSString *)username
                                               userid:(NSString *)userid
                                         newsId:(NSString *)newsId;

@end
