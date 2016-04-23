//
//  JYBFileTypeCollectionView.h
//  JianYunBao
//
//  Created by faith on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
  JYBDownloadFileTypeMP3,
  JYBDownloadFileTypeMP4,
  JYBDownloadFileTypeImage,
} JYBDownloadFileType;

typedef void(^AddBlock)();
typedef void(^SubstractBlock)();
@interface JYBFileTypeCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic , copy)NSMutableArray *imageArr;
@property(nonatomic , copy)NSMutableArray *nameArr;
@property(nonatomic ,assign)NSInteger type;
@property(nonatomic ,copy) AddBlock  addBlock;
@property(nonatomic ,copy) SubstractBlock substractBlock;
@property (nonatomic ,assign)JYBDownloadFileType fileType;
@property (nonatomic ,assign) BOOL isDelect;
@end
