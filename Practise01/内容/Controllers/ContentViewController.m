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
#define titleScrollViewH 40

@interface ContentViewController ()
//头部视图
@property (nonatomic, strong) ContentHeaderView *headerView;
//数据缓存数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//记录应用开启刷新
@property (nonatomic, assign) BOOL update;
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

static NSString *identifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated {
    //第一次Appear时自动进行刷新
    if (!self.update) {
        [self.tableView.header beginRefreshing];
        self.update = YES;
    }
}

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
    //添加上拉刷新和下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeaderData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooterData)];
    //设置应用启动刷新状态
    self.update = NO;
}

#pragma mark --- addHeaderView
- (void)addHeaderView {
    ContentHeaderView *headerView = [[ContentHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderViewH)];
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
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/%u-20.html", self.urlStr, (int)self.dataArray.count - self.dataArray.count%10];
    [self loadDataForType:2 withURL:url];
}

- (void)loadDataForType:(NSInteger)type withURL:(NSString *)url {
    //idStr：用于从数据库中的对应表中查找实体数据
    NSString *idStr = nil;
    idStr = [[self.urlStr componentsSeparatedByString:@"/"] lastObject];
    [DataTool getDataWithURL:url parameter:nil iDStr:idStr success:^(id responseObject) {
        //1.模型转对象
        NSArray *tempArr = responseObject;
        
        //2.区别上拉刷新和下拉刷新
        switch (type) {
            case 1:{//上拉刷新
                //清空self.dataArray的所有数据
                [self.dataArray removeAllObjects];
                //临时数组，注意数组传递，切勿误只传指针!!!
                NSMutableArray *headerViewArr = [NSMutableArray arrayWithCapacity:4];
                NSMutableArray *tableViewCellArr = [NSMutableArray array];
                for (NewsModel *newsModel in tempArr) {
                    if (headerViewArr.count <= 3) {
                        [headerViewArr addObject:newsModel];
                    }
                    [tableViewCellArr addObject:newsModel];
                }
                //移除已添加到头部视图的新闻模型对象
                [tableViewCellArr removeObjectsInArray:headerViewArr];
                //赋值相应实际用到的数组
                self.headerView.arr = headerViewArr;
                self.dataArray = tableViewCellArr;
                [self.tableView.header endRefreshing];
                [self.tableView reloadData];
                break;
            }
            case 2:{//下拉刷新
                
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
#warning Incomplete implementation, return the number of sections
    return self.dataArray.count;
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
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
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
