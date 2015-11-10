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
#import "LeftMenuViewController.h"
#import "Define.h"

//动画时间
#define Duration 0.3
//缩放比例
#define scaleX 0.75
#define scaleY 0.75
//leftView的宽度
#define leftViewWidth 200

@interface MainViewController ()
//当前显示的view
@property (nonatomic, strong) UIView *visibleView;
//子控制器视图
@property (nonatomic, strong) UIView *homeView;
//leftView
@property (nonatomic, strong) UIView *leftView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加背景图
    [self addBackground];
    //添加子控制器
    [self addChildControllers];
}

#pragma mark --- addBackground
- (void)addBackground {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_cover_gaussian"]];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

#pragma mark --- addChildController

- (void)addChildControllers {
    //添加菜单子控制器
    LeftMenuViewController *leftMenuVC = [[LeftMenuViewController alloc] init];
    [self addChildViewController:leftMenuVC];
    [self.view insertSubview:leftMenuVC.view atIndex:2];
    //隐藏菜单视图
    self.leftView = leftMenuVC.view;
    leftMenuVC.view.hidden = YES;
    //添加首页子控制器
    HomeViewController *homePageVC = [[HomeViewController alloc] init];
    self.homeView = homePageVC.view;
    [self setUpViewController:homePageVC withTitle:@"新闻"];
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
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonSelector:)];
//    viewController.navigationItem.rightBarButtonItem = rightButton;
    
    //如果是新闻视图，则加载view
    [self.view addSubview:nv.view];
    if ([title isEqualToString:@"新闻"]) {
        self.visibleView = nv.view;
    }
}

#pragma mark --- Method of NavigationBarButtons

- (void)leftButtonSelector:(UIBarButtonItem*)sender {
    //显示leftMenu视图
    self.leftView.hidden = NO;
    //动画开始效果设置
    self.leftView.transform = CGAffineTransformMakeTranslation(-200, 0);
    self.leftView.alpha = 0.5;
    //动画设置
    [UIView animateWithDuration:Duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //恢复leftView
        self.leftView.alpha = 1.0;
        self.leftView.transform = CGAffineTransformIdentity;
        //visibleView效果
        self.visibleView.transform = CGAffineTransformMakeTranslation(200, 0);
//        self.visibleView.alpha = 0.5;
    } completion:^(BOOL finished) {
        //动画结束添加coverBTN
        UIButton *coverBTN = [[UIButton alloc] initWithFrame:self.visibleView.bounds];
        [coverBTN addTarget:self action:@selector(leftButtonSelectorBack:) forControlEvents:UIControlEventTouchUpInside];
        [self.visibleView addSubview:coverBTN];
    }];
}

- (void)leftButtonSelectorBack:(UIButton *)sender {
    [UIView animateWithDuration:Duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //leftMenu动画效果
        self.leftView.alpha = 0.5;
        self.leftView.transform = CGAffineTransformMakeTranslation(-200, 0);
        //visibleView动画效果
//        self.visibleView.alpha = 1.0;
        self.visibleView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //隐藏leftView
        self.leftView.hidden = YES;
        //动画结束移除coverBTN
        [sender removeFromSuperview];
    }];
}

//- (void)rightButtonSelector:(UIBarButtonItem*)sender {
//    NSLog(@"touch rightButton");
//}

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
