//
//  JYBFileTypeCollectionView.m
//  JianYunBao
//
//  Created by faith on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFileTypeCollectionView.h"
#import "UIImageView+WebCache.h"
#import "GetMoviIamge.h"
#import "JYBFileDownloadHandler.h"
#import "EMCDDeviceManager.h"
@interface JYBFileTypeCollectionView()

@end

@implementation JYBFileTypeCollectionView
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
  self = [super initWithFrame:frame collectionViewLayout:layout ];
  if(self)
  {
    [self config];
  }
  return self;
}
- (void)config
{
  self.dataSource=self;
  self.delegate=self;
  [self setBackgroundColor:[UIColor whiteColor]];
  [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}
#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  if(self.type ==0)
  {
    return _imageArr.count +2;
  }
  else if(self.type ==1)
  {
    if(self.isDelect)
    {
      return _imageArr.count;
    }
    return _imageArr.count +1;

  }
  return 0;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * CellIdentifier = @"UICollectionViewCell";
  UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, Mwidth/4 - 40, Mwidth/4 - 40)];
  iconImage.userInteractionEnabled = YES;
  UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Mwidth/4 - 25, Mwidth/4, 20)];
  nameLabel.font = [UIFont systemFontOfSize:9];
  nameLabel.textAlignment = NSTextAlignmentCenter;
  [cell.contentView addSubview:iconImage];
  [cell.contentView addSubview:nameLabel];
  if(self.type ==0)
  {
    if(indexPath.row < _imageArr.count)
    {
      [iconImage sd_setImageWithURL:_imageArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
      nameLabel.text = _nameArr[indexPath.row];
    }
    else if (indexPath.row == _imageArr.count)
    {
      iconImage.image = [UIImage imageNamed:@"添加"];
      nameLabel.text = @"";
    }
    else if (indexPath.row == _imageArr.count +1)
    {
      iconImage.image = [UIImage imageNamed:@"减少"];
      nameLabel.text = @"";
    }
  }
  else if (self.type ==1)
  {
    if(_isDelect)
    {
      UIImageView *delectImage = [[UIImageView alloc] initWithFrame:CGRectMake(iconImage.right - 20, iconImage.y, 20, 20)];
      delectImage.image = [UIImage imageNamed:@"收起附件"];
      [cell.contentView addSubview:delectImage];
    }
    if(indexPath.row < _imageArr.count)
    {
      if(self.fileType ==JYBDownloadFileTypeImage)
      {
        [iconImage sd_setImageWithURL:_imageArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
          nameLabel.text = @"";
      }
      else if (self.fileType ==JYBDownloadFileTypeMP3)
      {
        iconImage.image = [UIImage imageNamed:@"chat_receiver_audio_playing_full"];
        nameLabel.text = _nameArr[indexPath.row];
      }
      else if (self.fileType ==JYBDownloadFileTypeMP4)
      {
        iconImage.image = [GetMoviIamge thumbnailImageForVideo:_imageArr[indexPath.row]];
        nameLabel.text = _nameArr[indexPath.row];
      }
    }
    else if (indexPath.row ==_imageArr.count)
    {
      iconImage.image = [UIImage imageNamed:@"减少"];
      nameLabel.text = @"";
    }
  }
  return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(Mwidth/4, Mwidth/4);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 0.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 0.0f;
}
#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  if(self.type ==0)
  {
    if(indexPath.row ==_imageArr.count && self.addBlock)
    {
      self.addBlock();
    }
    else if (indexPath.row == _imageArr.count +1 && self.substractBlock)
    {
      self.substractBlock();
    }

  }
  else if (self.type ==1)
  {
    if(indexPath.row < _imageArr.count)
    {
      [JYBFileDownloadHandler downloadAudioWithAudioPath:[_imageArr[indexPath.row] absoluteString] finished:^(NSString *localPath) {
        [self playAudioVithLocalPath:localPath];
      }];

    }
    else if (indexPath.row == _imageArr.count && self.substractBlock)
    {
      self.substractBlock();
      _isDelect = YES;
      
      [self reloadData];
    }
  }
}
- (void)playAudioVithLocalPath:(NSString *)localPath
{
  NSString *recordPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:[recordPath stringByAppendingFormat:@"%@",localPath] completion:^(NSError *error) {
  }];

}

@end
