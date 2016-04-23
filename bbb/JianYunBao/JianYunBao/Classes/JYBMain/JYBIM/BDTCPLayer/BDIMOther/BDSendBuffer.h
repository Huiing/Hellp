//
//  BDSendBuffer.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDSendBuffer : NSMutableData
{
    @private
    NSMutableData *outputData;//要发送的数据
    NSInteger sendPos;//len
}

@property (nonatomic, assign) NSInteger sendPos;
- (instancetype)initWithData:(NSData *)newData;
+ (instancetype)dataWithData:(NSData *)newData;

- (void)consumeData:(NSInteger)length;

- (const void *)bytes;
- (NSUInteger)length;
- (void *)mutableBytes;
- (void)setLength:(NSUInteger)length;

@end
