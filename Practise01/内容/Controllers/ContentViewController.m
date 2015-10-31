//
//  ContentViewController.m
//  Practise01
//
//  Created by tarena on 15/10/27.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentViewController.h"
#import "Define.h"
#import "ContentHeaderView.h"
#import "ContentViewCell.h"
#define titleScrollViewH 40

@interface ContentViewController ()
//头部视图
@property (nonatomic, strong) ContentHeaderView *headerView;
@end

@implementation ContentViewController

static NSString *identifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //设置分割线的样式为None
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    //添加头部视图
    [self addHeaderView];
}

#pragma mark --- addHeaderView
- (void)addHeaderView {
    ContentHeaderView *headerView = [[ContentHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderViewH)];
    [self.tableView setTableHeaderView:headerView];
    self.headerView = headerView;
#warning 头部视图Demo数据（应该放在进行下拉或者上拉网络数据请求的时候，添加数据）
#warning 添加onceToken为了模拟
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *demoArr = @[@"第一条新闻", @"第二条新闻", @"第三条新闻", @"第四条新闻"];
        self.headerView.arr = demoArr;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.backgroundColor = [UIColor grayColor];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning TODO;
}

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
