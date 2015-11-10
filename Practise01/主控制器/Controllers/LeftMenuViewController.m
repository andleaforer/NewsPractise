//
//  LeftMenuViewController.m
//  Practise01
//
//  Created by tarena on 15/11/10.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "Define.h"
#import "LeftMenuHeaderView.h"
#import "TableViewCellView.h"
#import "DataBaseTool.h"
#import <CoreData/CoreData.h>

@interface LeftMenuViewController ()
//头部视图
@property (nonatomic, strong) LeftMenuHeaderView *headerView;
@end

@implementation LeftMenuViewController

static NSString *identifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //测试Dark
    //设置背景颜色
    self.view.backgroundColor = [UIColor clearColor];
    //添加头部视图
    [self addHeaderView];
    //注册Cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    //设置tableView分割线样式:None
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - addHeaderView
- (void)addHeaderView {
    LeftMenuHeaderView *headerView = [[LeftMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    self.headerView = headerView;
    [self.tableView setTableHeaderView:headerView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.backgroundColor = [UIColor clearColor];
    //设置tag
    cell.tag = indexPath.row;
    switch (indexPath.row) {
        case 0:{
            TableViewCellView *cellView = [[TableViewCellView alloc] initWithImageSrc:@"settings_full_ico" title:@"News"];
            [cell.contentView addSubview:cellView];
            break;
        }
        case 1:{
            TableViewCellView *cellView = [[TableViewCellView alloc] initWithImageSrc:@"settings_news_push_ico" title:@"Mark"];
            [cell.contentView addSubview:cellView];
            break;
        }
        case 2:{
            TableViewCellView *cellView = [[TableViewCellView alloc] initWithImageSrc:@"settings_Empty_Cache_ico" title:@"Clean"];
            [cell.contentView addSubview:cellView];
            break;
        }
        case 3:{
            TableViewCellView *cellView = [[TableViewCellView alloc] initWithImageSrc:@"settings_version_ico" title:@"Night"];
            [cell.contentView addSubview:cellView];
            break;
        }
    }
    //底部细线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 43, 140, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:lineView];
    //选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    switch (selectedCell.tag) {
        case 0:{//切换到新闻
            
            break;
        }
        case 1:{//切换到收藏
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToMarkBook" object:nil];
            break;
        }
        case 2:{//清除缓存
            [DataBaseTool deleteAllModel];
            break;
        }
        case 3:{//切换白天夜晚
            NSLog(@"nightFalling");
            break;
        }
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 132)];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
