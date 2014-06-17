//
//  PictureShowViewController.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "PictureShowViewController.h"
#import "PictureShowView.h"

@interface PictureShowViewController ()
@property(nonatomic,retain)PictureShowView * pictureShowView;
@end

@implementation PictureShowViewController
- (void)dealloc
{
    RELEASE_SAFELY(_pictureShowView);
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
    self.pictureShowView = [[[PictureShowView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _pictureShowView;
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pictureShowView.backgroundColor = [UIColor whiteColor];
   self.navigationItem.title = @"图片展示";
    [self handleAsynPictureDataItem];
}


- (void)handleAsynPictureDataItem
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
//    [fileManager fileExistsAtPath:]
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"cachesPath = %@",cachesPath);
    //目录
    NSString * itemsPath = [cachesPath stringByAppendingPathComponent:@"picture"];
    NSLog(@"itemsPath = %@",itemsPath);
    if ([fileManager fileExistsAtPath:itemsPath]) {
        
        [fileManager createDirectoryAtPath:itemsPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    for (int i = 0; i < 9; i ++) {
        
        NSString * urlString = [NSString stringWithFormat:@"http://img3.fengniao.com/forum/attachpics/764/74/3053464%d.jpg",i];
        NSString * fileName = [urlString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        NSLog(@"file Name %@",fileName);
        
        NSString * filePaht = [itemsPath stringByAppendingPathComponent:fileName];
        NSURL * url = [NSURL URLWithString:urlString];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [data writeToFile:filePaht atomically:YES];
            UIImageView * imageView = [_pictureShowView.imageViewArray objectAtIndex:i];
            imageView.image = [UIImage imageWithData:data];
        }];
    }
}
- (void)handleAsynPictureDataDelegate
{



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
