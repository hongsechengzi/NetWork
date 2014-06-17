//
//  PictureView.h
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureView;
@protocol PictureViewDelegate <NSObject>

- (void)pictureViewDidClickDownloadButtonAction:(PictureView *)pictureView;

@end


@interface PictureView : UIView
@property(nonatomic,readonly)UIImageView * picture;
@property(nonatomic,readonly)UILabel * scheduleLabel;
@property(nonatomic,readonly)UIProgressView * progressView;
@property(nonatomic,assign)id<PictureViewDelegate> delegate;
@end
