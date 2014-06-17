//
//  PictureView.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "PictureView.h"

@implementation PictureView
- (void)dealloc
{
    RELEASE_SAFELY(_picture);
    RELEASE_SAFELY(_scheduleLabel);
    RELEASE_SAFELY(_progressView);
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width/2, height/2)];
    _picture.center = CGPointMake(width/2, height/2);
    _picture.backgroundColor = [UIColor yellowColor];
    [self addSubview:_picture];
    
    UIButton * downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    downloadButton.frame = CGRectMake(130, 500, 60, 30);
    [downloadButton setTitle:@"下载" forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(didClickDownloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:downloadButton];
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(100, 450, 120, 30);
    _progressView.tintColor = [UIColor grayColor];
    [self addSubview:_progressView];
    
   _scheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 435, 60, 30)];
    _scheduleLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:_scheduleLabel];

}

- (void)didClickDownloadButtonAction:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(pictureViewDidClickDownloadButtonAction:)]) {
        [_delegate pictureViewDidClickDownloadButtonAction:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
