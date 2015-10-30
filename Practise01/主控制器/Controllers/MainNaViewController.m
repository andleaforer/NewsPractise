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
//    [self setUpNavigationBar];
}

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置背景颜色
    [navBar setBarTintColor:[UIColor whiteColor]];
    //设置item的tint颜色
    [navBar setTintColor:[UIColor redColor]];
    //设置
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    navBar.shadowImage=[[UIImage alloc]init];  //隐藏掉导航栏底部的那条线
    //2.设置导航栏barButton上面文字的颜色
//    UIBarButtonItem *item=[UIBarButtonItem appearance];
//    [item setTintColor:[UIColor whiteColor]];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

#pragma mark --- self.navigationBar/navigationItem

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
