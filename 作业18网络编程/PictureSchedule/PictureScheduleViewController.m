//
//  PictureScheduleViewController.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "PictureScheduleViewController.h"


@interface PictureScheduleViewController ()
{
     NSInteger _contentLength;
}
@property(nonatomic,retain)PictureView * pictureView;
@property(nonatomic,retain)NSMutableData * receiveData;
@end


@implementation PictureScheduleViewController
- (void)dealloc
{
    RELEASE_SAFELY(_pictureView);
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    self.pictureView = [[[PictureView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _pictureView;
    _pictureView.delegate = self;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pictureView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图片进度";
}

//下载按钮响应
- (void)pictureViewDidClickDownloadButtonAction:(PictureView *)pictureView
{
   NSString * urlString = @"http://image.tianjimedia.com/uploadImages/2013/185/5G8Z8DYU6HI9.jpg";    
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary * httpResponseDic = httpResponse.allHeaderFields;
    NSString * contentLengthString = [httpResponseDic objectForKey:@"Content-Length"];
    _contentLength = [contentLengthString integerValue];
//     NSLog(@"contentLength = %ld",_contentLength);
//    NSLog(@"contentLengthString = %@",contentLengthString);
//    NSLog(@"httpResponseDic = %@",httpResponseDic);
    self.receiveData = [NSMutableData data];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
    NSInteger receiveDataLength = _receiveData.length;
   // NSLog(@"receiveDataLength = %ld",receiveDataLength);
    _pictureView.progressView.progress = (CGFloat)receiveDataLength/_contentLength;
    _pictureView.scheduleLabel.text = [NSString stringWithFormat:@"%.0f%%",100 * _pictureView.progressView.progress];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _pictureView.picture.image = [UIImage imageWithData:_receiveData];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
