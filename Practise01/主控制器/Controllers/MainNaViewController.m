//
//  MainNaViewController.m
//  Practise01
//
//  Created by Haoran on 15/10/25.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "MainNaViewController.h"

@interface MainNaViewController ()

@end

@implementation MainNaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置NavigationBar
    [self setUpNavigationBar];
}

#pragma mark --- self.navigationBar/navigationItem

- (void)setUpNavigationBar {
    //显示navigationBar，设置title，设置navigationBar的颜色
    self.navigationItem.title = @"News";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //添加左按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonSelector:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    //添加右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonSelector:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark --- Method of NavigationBarButtons

- (void)leftButtonSelector:(UIBarButtonItem*)sender {
    NSLog(@"touch leftButton");
}

- (void)rightButtonSelector:(UIBarButtonItem*)sender {
    NSLog(@"touch rightButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
