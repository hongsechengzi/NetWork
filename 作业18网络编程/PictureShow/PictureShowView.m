//
//  PictureShowView.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "PictureShowView.h"

@implementation PictureShowView
- (void)dealloc
{
    RELEASE_SAFELY(_imageViewArray);
    [super dealloc];

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews
{
    _imageViewArray = [[NSMutableArray alloc] init];
    int j = 0,k = 0;
    for (int i = 0; i < 9; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5 + (j*105), 100 + (k*130), 100, 120)];
        imageView.backgroundColor = [UIColor cyanColor];
        [self addSubview:imageView];
        j++;
        if (j == 3) {
            j = 0;
            k++;
        }
        [_imageViewArray addObject:imageView];
        [imageView release];
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
