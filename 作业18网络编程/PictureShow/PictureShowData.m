//
//  PictureShowData.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "PictureShowData.h"

@interface PictureShowData ()
@property(nonatomic,retain)NSMutableData * receiveData;

@end

@implementation PictureShowData
- (void)dealloc
{
    RELEASE_SAFELY(_receiveData);
    [super dealloc];
}

- (void)handleAsynPictureData
{
    for (int i = 0; i < 9; i ++) {
        NSString * urlString = [NSString stringWithFormat:@"http://img3.fengniao.com/forum/attachpics/764/74/3053464%d.jpg",i];
        NSURL * url = [NSURL URLWithString:urlString];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData data];

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
 

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    NSLog(@"error = %@",error);
}
@end
