//
//  NewsTableViewController.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "NewsTableViewController.h"

@interface NewsTableViewController ()
@property(nonatomic,retain)NSMutableArray * newsTitleArray;
@property(nonatomic,retain)NSMutableData * receiveData;
@end

@implementation NewsTableViewController
- (void)dealloc
{
    RELEASE_SAFELY(_newsTitleArray);
    RELEASE_SAFELY(_receiveData);
    [super dealloc];

}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"新闻展示";
    [self handleJSONParserData];
    
}

- (void)handleJSONParserData
{
    self.newsTitleArray = [NSMutableArray array];
    NSString * urlString = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString * query = @"date=20131129&startRecord=5&len=26&udid=1234567890&terminalType=Iphone&cid=213";
    [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue ] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"jsonDic%@",jsonDic);
       
         NSArray * newsArray = [jsonDic objectForKey:@"news"];
         for (NSDictionary * newsDic in newsArray) {
          NSString * newsTitle =  [newsDic objectForKey:@"title"];
             NSLog(@"%@",newsTitle);
             [_newsTitleArray addObject:newsTitle];
        }
         [self.tableView reloadData];
          NSLog(@"newsTitleArray = %@",_newsTitleArray);
    }];
    NSLog(@"------newsTitleArray = %@",_newsTitleArray);
}

- (void)handleJSONParserDataAsyn
{
    self.newsTitleArray = [NSMutableArray array];
    NSString * urlString = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString * query = @"date=20131129&startRecord=5&len=26&udid=1234567890&terminalType=Iphone&cid=213";
    [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.newsTitleArray = [NSMutableArray array];
    self.receiveData = [NSMutableData data];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:_receiveData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"jsonDic%@",jsonDic);
    
    NSArray * newsArray = [jsonDic objectForKey:@"news"];
    for (NSDictionary * newsDic in newsArray) {
        NSString * newsTitle =  [newsDic objectForKey:@"title"];
       // NSLog(@"%@",newsTitle);
        [_newsTitleArray addObject:newsTitle];
    }
    NSLog(@"newsTitleArray = %@",_newsTitleArray);
    
    [self.tableView reloadData];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_newsTitleArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * string = [_newsTitleArray objectAtIndex:indexPath.row];
    static NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = string;
    cell.textLabel.numberOfLines = 0;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
