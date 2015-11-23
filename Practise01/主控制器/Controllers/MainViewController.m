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
#import "MarkViewController.h"
#import "RadioViewController.h"
#import "CommentViewController.h"

//动画时间
#define Duration 0.3
//缩放比例
#define scaleX 0.75
#define scaleY 0.75
//leftView的宽度
#define leftViewWidth 200

@interface MainViewController () <LeftMenuViewControllerDelegate>
//当前显示的view
@property (nonatomic, strong) UIView *visibleView;
//leftView
@property (nonatomic, strong) UIView *leftView;
//rightView
@property (nonatomic, strong) UIView *rightView;

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
    //内容模式：等比例放大，然后充满屏幕
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
    leftMenuVC.delegate = self;
    //隐藏菜单视图
    self.leftView = leftMenuVC.view;
//    leftMenuVC.view.hidden = YES;
    //添加首页子控制器
    HomeViewController *homePageVC = [[HomeViewController alloc] init];
    [self setUpViewController:homePageVC withTitle:@"新闻"];
    //添加电台子控制器
    RadioViewController *radioVC = [[RadioViewController alloc] init];
    [self setUpViewController:radioVC withTitle:@"小说"];
    //添加收藏子控制器
    MarkViewController *markVC = [[MarkViewController alloc] init];
    [self setUpViewController:markVC withTitle:@"收藏"];
}

- (void)setUpViewController:(UIViewController *)viewController withTitle:(NSString *)title {
    MainNaViewController *nv = [[MainNaViewController alloc] initWithRootViewController:viewController];
    //添加到父控制器
    [self addChildViewController:nv];
    viewController.navigationItem.title = title;
    //添加左按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_infoicon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonSelector:)];
    viewController.navigationItem.leftBarButtonItem = leftButton;
    //添加右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonSelector:)];
    viewController.navigationItem.rightBarButtonItem = rightButton;
    //暂时不显示的view隐藏
//    nv.view.hidden = YES;
    if ([title isEqualToString:@"新闻"]) {
        //如果是新闻视图，则加载view
        [self.view addSubview:nv.view];
        self.visibleView = nv.view;
//        nv.view.hidden = NO;
    }
}

#pragma mark --- Method of NavigationBarButtons

- (void)leftButtonSelector:(UIBarButtonItem*)sender {
    //显示leftMenu视图
//    self.leftView.hidden = NO;
    //动画开始效果设置
    self.leftView.transform = CGAffineTransformMakeTranslation(-200, 0);
    self.leftView.alpha = 0.0f;
    //动画设置
    [UIView animateWithDuration:Duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //恢复leftView
        self.leftView.alpha = 1.0f;
        self.leftView.transform = CGAffineTransformIdentity;
        //visibleView效果
        CGAffineTransform scale = CGAffineTransformMakeScale(0.7, 0.7);
        CGAffineTransform trans = CGAffineTransformMakeTranslation(150, 0);
        CGAffineTransform transform = CGAffineTransformConcat(scale, trans);
        self.visibleView.transform = transform;
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
        self.leftView.alpha = 0.0f;
        self.leftView.transform = CGAffineTransformMakeTranslation(-200, 0);
        //visibleView动画效果
//        self.visibleView.alpha = 1.0;
        self.visibleView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //隐藏leftView
//        self.leftView.hidden = YES;
        //动画结束移除coverBTN
        [sender removeFromSuperview];
    }];
}

- (void)rightButtonSelector:(UIBarButtonItem*)sender {
    
}

#pragma mark --- addRightMenu 

- (void)addRightMenu {
    
}

#pragma mark - LeftMenuViewControllerDelegate
- (void)changeViewToTargetController:(NSInteger)index {
    //1.获取目标控制器及视图
    UIViewController *targetVC = self.childViewControllers[index];
    UIView *targetView = targetVC.view;
//    targetView.hidden = NO;
    //2.传递属性
    UIButton *button = (UIButton *)[self.visibleView.subviews lastObject];
    [targetView addSubview:button];
    targetView.transform = self.visibleView.transform;
    //3.移除原显示视图
    [self.visibleView removeFromSuperview];
    //4.将目标视图设置为当前显示视图
    self.visibleView = targetView;
    //5.添加到当前视图
    [self.view addSubview:self.visibleView];
    //6.执行动作
    [self leftButtonSelectorBack:button];
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
