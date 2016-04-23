//
//  IChatMessageReadManager.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/6.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatMessageReadManager.h"
#import "EMCDDeviceManager.h"
#import "BDIMDatabaseUtil.h"

static IChatMessageReadManager *detailInstance = nil;

@interface IChatMessageReadManager ()

@property (strong, nonatomic) UIWindow *keyWindow;

@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) UINavigationController *photoNavigationController;

@end

@implementation IChatMessageReadManager

+ (id)defaultManager
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            detailInstance = [[self alloc] init];
        });
    }
    
    return detailInstance;
}

#pragma mark - getter

- (UIWindow *)keyWindow
{
    if(_keyWindow == nil)
    {
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    
    return _keyWindow;
}

- (NSMutableArray *)photos
{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc] init];
    }
    
    return _photos;
}

- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}


#pragma mark - private


#pragma mark - public

- (void)showBrowserWithImages:(NSArray *)imageArray
{
    if (imageArray && [imageArray count] > 0) {
        NSMutableArray *photoArray = [NSMutableArray array];
        for (id object in imageArray) {
            MWPhoto *photo = nil;
            if ([object isKindOfClass:[UIImage class]]) {
                photo = [MWPhoto photoWithImage:object];
            }
            else if ([object isKindOfClass:[NSURL class]])
            {
                photo = [MWPhoto photoWithURL:object];
            }
            else if ([object isKindOfClass:[NSString class]])
            {
                
            }
            /*!
             *  @author 冰点, 16-03-15 12:03:49
             *
             *  @brief 内存泄露处理
             */
            if (photo != nil) {
                [photoArray addObject:photo];
            }
        }
        
        self.photos = photoArray;
    }
    
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
}

- (BOOL)prepareMessageAudioModel:(JYBIChatMessage *)messageModel
            updateViewCompletion:(void (^)(JYBIChatMessage *prevAudioModel, JYBIChatMessage *currentAudioModel))updateCompletion
{
    BOOL isPrepare = NO;
    
    if(messageModel.messageBodyType == JYBIMMessageBodyTypeAudio)
    {
        JYBIChatMessage *prevAudioModel = self.audioMessageModel;
        JYBIChatMessage *currentAudioModel = messageModel;
        self.audioMessageModel = messageModel;
        
        BOOL isPlaying = messageModel.isPlaying;
        if (isPlaying) {
            messageModel.isPlaying = NO;
            self.audioMessageModel = nil;
            currentAudioModel = nil;
            [[EMCDDeviceManager sharedInstance] stopPlaying];
        }
        else {
            messageModel.isPlaying = YES;
            prevAudioModel.isPlaying = NO;
            isPrepare = YES;
            
            if (!messageModel.isPlayed) {
                messageModel.isPlayed = YES;
                messageModel.isRead = YES;
                [[BDIMDatabaseUtil sharedInstance] updateIChatMessageWithIChatMessage:messageModel success:^{}];
            }
    }
        if (updateCompletion) {
            updateCompletion(prevAudioModel, currentAudioModel);
        }
    }
    return isPrepare;
}

- (JYBIChatMessage *)stopMessageAudioModel
{
    JYBIChatMessage *model = nil;
    if (self.audioMessageModel.messageBodyType == JYBIMMessageBodyTypeAudio) {
        if (self.audioMessageModel.isPlaying) {
            model = self.audioMessageModel;
        }
        self.audioMessageModel.isPlaying = NO;
        self.audioMessageModel = nil;
    }
    
    return model;
}

@end
