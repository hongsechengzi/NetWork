//
//  DownloadTableViewController.m
//  作业18网络编程
//
//  Created by lanou3g on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "DownloadTableViewController.h"
#import "PictureShowViewController.h"
#import "NewsTableViewController.h"
#import "PictureScheduleViewController.h"



@interface DownloadTableViewController ()

@property(nonatomic,retain)NSArray * cellShowArray;

@end

@implementation DownloadTableViewController
- (void)dealloc
{
    RELEASE_SAFELY(_cellShowArray);
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
    self.navigationItem.title = @"下载练习";
    self.cellShowArray = @[@"单张图片下载(异步链接,展示下载进度)",@"展示新闻标题(第5~30条)",@"9张图片下载(异步链接,不展示下载进度)"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellShowArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellText = [_cellShowArray objectAtIndex:indexPath.row];
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
  //  NSLog(@"%@",cellText);
    cell.textLabel.text = cellText;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PictureScheduleViewController * pictureScheduleVC = [[PictureScheduleViewController alloc] init];
        [self.navigationController pushViewController:pictureScheduleVC animated:YES];
        [pictureScheduleVC release];
    }else if (indexPath.row == 1){
        NewsTableViewController * newsVC = [[NewsTableViewController alloc] init];
        [self.navigationController pushViewController:newsVC animated:YES];
        [newsVC release];
    
    }else{
        PictureShowViewController * pictureShowVC = [[PictureShowViewController alloc] init];
        [self.navigationController pushViewController:pictureShowVC animated:YES];
        [pictureShowVC release];
    }
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
