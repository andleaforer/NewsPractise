//
//  MainViewController.m
//  Practise01
//
//  Created by Haoran on 15/10/25.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "MainViewController.h"
#import "MainNaViewController.h"
#import "HomeViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加左边菜单栏视图
    [self addLeftMenu];
    //添加子控制器
    [self addChildControllers];
    //添加右边菜单栏视图
    [self addRightMenu];
}

#pragma mark --- addLeftMenu

- (void)addLeftMenu {
    
}

#pragma mark --- addChildController

- (void)addChildControllers {
    //添加首页子控制器
    HomeViewController *homePageVC = [[HomeViewController alloc] init];
    [self setUpViewController:homePageVC withTitle:@"新闻"];
#warning TODO;
    //添加订阅子控制器
}

- (void)setUpViewController:(UIViewController *)viewController withTitle:(NSString *)title {
    MainNaViewController *nv = [[MainNaViewController alloc] initWithRootViewController:viewController];
    //添加到父控制器
    [self addChildViewController:nv];
    
    viewController.navigationItem.title = title;
    //添加左按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonSelector:)];
    viewController.navigationItem.leftBarButtonItem = leftButton;
    //添加右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonSelector:)];
    viewController.navigationItem.rightBarButtonItem = rightButton;
    
    //如果是新闻视图，则加载view
    if ([title isEqualToString:@"新闻"]) {
        [self.view addSubview:nv.view];
    }
}

#pragma mark --- Method of NavigationBarButtons

- (void)leftButtonSelector:(UIBarButtonItem*)sender {
    NSLog(@"touch leftButton");
}

- (void)rightButtonSelector:(UIBarButtonItem*)sender {
    NSLog(@"touch rightButton");
}


#pragma mark --- addRightMenu 

- (void)addRightMenu {
    
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
