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
#import "MJRefresh.h"
#import "DataTool.h"
#import "NSObject+MJKeyValue.h"
#import "NewsModel.h"
#import "DetailViewController.h"
#define titleScrollViewH 40

@interface ContentViewController ()
//头部视图
@property (nonatomic, strong) ContentHeaderView *headerView;
//数据缓存数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//数据数组
@property (nonatomic, strong) NSMutableArray *tableViewArr;
//记录应用开启刷新
@property (nonatomic, assign) BOOL update;
//记录刷新次数
@property (nonatomic, assign) int refreshCount;
@end

@implementation ContentViewController

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray ) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)tableViewArr {
    if (!_tableViewArr) {
        _tableViewArr = [NSMutableArray array];
    }
    return _tableViewArr;
}

static NSString *identifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated {
    //第一次Appear时自动进行刷新
    if (!self.update) {
        [self.tableView.header beginRefreshing];
        self.update = YES;
    }
    //2.显示navigationBar
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshCount = 0;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.view.backgroundColor = [UIColor redColor];
    //设置分割线的样式为None
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    //添加头部视图
    [self addHeaderView];
    //添加上拉刷新和下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeaderData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    //设置应用启动刷新状态
    self.update = NO;
    
}

#pragma mark --- addHeaderView
- (void)addHeaderView {
    ContentHeaderView *headerView = [[ContentHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderViewH)];
    //底部的灰线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HeaderViewH - 1, ScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.3;
    [headerView addSubview:lineView];
    headerView.block = ^(NewsModel *newsModel){
        DetailViewController *detailVC = [DetailViewController new];
        detailVC.newsModel = newsModel;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    [self.tableView setTableHeaderView:headerView];
    self.headerView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- MJRefresh method

- (void)loadHeaderData {
#warning TODO - 考虑没有网络连接的情况
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/0-20.html", self.urlStr];
    [self loadDataForType:1 withURL:url];
}

- (void)loadFooterData {
#warning TODO - 考虑没有网络连接的情况
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/%d-20.html", self.urlStr, (int)self.tableViewArr.count - (int)self.tableViewArr.count % 10];
    NSLog(@"Count:%d", (int)self.tableViewArr.count);
    [self loadDataForType:2 withURL:url];
}

- (void)loadDataForType:(NSInteger)type withURL:(NSString *)url {
    //记录刷新次数
    self.refreshCount++;
    //idStr：用于从数据库中的对应表中查找实体数据
    NSString *idStr = nil;
    idStr = [[self.urlStr componentsSeparatedByString:@"/"] lastObject];
    [DataTool getDataWithURL:url parameter:nil iDStr:idStr refreshCount:self.refreshCount success:^(id responseObject) {
        //1.模型转对象
        NSArray *tempArr = responseObject;
        
        //临时数组，注意数组传递，切勿误只传指针!!!
        NSMutableArray *headerViewArr = [NSMutableArray arrayWithCapacity:4];
        //2.区别上拉刷新和下拉刷新
        switch (type) {
            case 1:{//上拉刷新
                //清空self.dataArray的所有数据
                [self.dataArray removeAllObjects];
                for (NewsModel *newsModel in tempArr) {
                    if (headerViewArr.count <= 3 && self.refreshCount == 1) {
                        [headerViewArr addObject:newsModel];
                    }
                    [self.tableViewArr addObject:newsModel];
                    [self.dataArray addObject:newsModel];
                }
                //赋值相应实际用到的数组
                self.headerView.arr = headerViewArr;
                //移除已添加到头部视图的新闻模型对象
                if (self.refreshCount == 1) {
                    [self.dataArray removeObjectsInArray:headerViewArr];
                }
                [self.tableView.header endRefreshing];
                [self.tableView reloadData];
                break;
            }
            case 2:{//下拉刷新
                for (NewsModel *newsModel in tempArr) {
                    [self.dataArray addObject:newsModel];
                    [self.tableViewArr addObject:newsModel];
                }
                [self.tableView.footer endRefreshing];
                [self.tableView reloadData];
                break;
            }
            default:
                break;
        }
    } failure:^(NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSLog(@"Error:%@", error.userInfo);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.newsModel = self.dataArray[indexPath.row];
//    cell.backgroundColor = [UIColor grayColor];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 5.0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 5.0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning TODO;
    DetailViewController *detailVC = [DetailViewController new];
    NewsModel *newsModel = self.dataArray[indexPath.row];
    detailVC.newsModel = newsModel;
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
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
