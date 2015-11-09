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
#import "Define.h"
#import "LeftView.h"

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
//leftView
@property (nonatomic, strong) LeftView *leftView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加背景图
    [self addBackground];
    //添加左边菜单栏视图
    [self addLeftMenu];
    //添加子控制器
    [self addChildControllers];
    //添加右边菜单栏视图
    [self addRightMenu];
}

#pragma mark --- addBackground
- (void)addBackground {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_cover_gaussian"]];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

#pragma mark --- addLeftMenu

- (void)addLeftMenu {
    LeftView *leftView = [LeftView createLeftViewWith:CGRectMake(0, (ScreenHeight - ScreenHeight * scaleY)/2, leftViewWidth, ScreenHeight * scaleY)];
    self.leftView = leftView;
    [self.view insertSubview:leftView atIndex:1];
    //隐藏leftView
    leftView.hidden = YES;
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
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonSelector:)];
//    viewController.navigationItem.rightBarButtonItem = rightButton;
    
    //如果是新闻视图，则加载view
    if ([title isEqualToString:@"新闻"]) {
        [self.view addSubview:nv.view];
        self.visibleView = nv.view;
    }
}

#pragma mark --- Method of NavigationBarButtons

- (void)leftButtonSelector:(UIBarButtonItem*)sender {
    //显示leftView
    self.leftView.hidden = NO;
    //先设置leftView的缩放，再从下面的block中恢复
    CGAffineTransform leftViewScale = CGAffineTransformMakeScale(scaleX, scaleY);
    CGAffineTransform leftViewTranslation = CGAffineTransformMakeTranslation(- 50, 0);
    self.leftView.transform = CGAffineTransformConcat(leftViewScale, leftViewTranslation);
    [UIView animateWithDuration:Duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //恢复leftView
        self.leftView.transform = CGAffineTransformIdentity;
        //设置动画效果
        CGAffineTransform scale = CGAffineTransformMakeScale(scaleX, scaleY);
        CGAffineTransform translation = CGAffineTransformMakeTranslation(200, 0);
        CGAffineTransform transform = CGAffineTransformConcat(scale, translation);
        self.visibleView.transform = transform;
    } completion:^(BOOL finished) {
        //设置回调按钮
        UIButton *coverBTN = [[UIButton alloc] initWithFrame:self.visibleView.bounds];
        [coverBTN addTarget:self action:@selector(leftButtonSelectorBack:) forControlEvents:UIControlEventTouchUpInside];
        [self.visibleView addSubview:coverBTN];
    }];
}

- (void)leftButtonSelectorBack:(UIButton *)sender {
    [UIView animateWithDuration:Duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //缩小leftView
        CGAffineTransform leftViewScale = CGAffineTransformMakeScale(scaleX, scaleY);
        CGAffineTransform leftViewTranslation = CGAffineTransformMakeTranslation(- 50, 0);
        self.leftView.transform = CGAffineTransformConcat(leftViewScale, leftViewTranslation);
        //恢复visibleView
        self.visibleView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //隐藏leftView
        self.leftView.hidden = YES;
        //移除本按钮
        [sender removeFromSuperview];
    }];
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
