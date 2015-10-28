//
//  MainViewController.m
//  Practise01
//
//  Created by tarena on 15/10/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleScrollViewLabel.h"
#import "ContentViewController.h"
#import "Define.h"

#define TitleScrollViewH 40
#define TitleLbH 30

@interface HomeViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
//假数据
@property (nonatomic, strong) NSArray *demoData;
@end

@implementation HomeViewController

static NSString *identifier = @"Cell";

- (NSArray *)demoData {
    if (!_demoData) {
        _demoData = @[@"头条", @"欧冠", @"NBA", @"InfoQ", @"Github", @"IGN", @"互联网", @"网游"];
    }
    return _demoData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置view的背景颜色为白色
    self.view.backgroundColor = [UIColor whiteColor];
    //添加标题栏视图ScrollView
    [self addTitleScrollView];
    //添加内容视图contentScrollView
    [self addContentScrollView];
    //添加标题栏Lable
    [self addLable];
    //添加子控制器
    [self addContentVC];
    //添加第一个子控制器
    ContentViewController *firstContentVC = (ContentViewController*)[self.childViewControllers firstObject];
//    [firstContentVC.view setBackgroundColor:[UIColor redColor]];
    CGRect viewFrame = CGRectMake(0, -64, ScreenWidth, ScreenHeight);
    [firstContentVC.view setFrame:viewFrame];
//    NSLog(@"%f", firstContentVC.view.frame.size.height);
    [self.contentScrollView addSubview:firstContentVC.view];
    NSLog(@"Mark03");
    TitleScrollViewLabel *firstLabel = (TitleScrollViewLabel*)[self.titleScrollView.subviews firstObject];
    [firstLabel setScale:1.0];
    //程序启动位移
//    [self.titleScrollView setContentOffset:CGPointMake(-(ScreenWidth/2-35), 0) animated:YES];
}

#pragma mark --- addTitleScrollView

- (void)addTitleScrollView {
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, TitleScrollViewH)];
//    [self.titleScrollView setBackgroundColor:[UIColor orangeColor]];
    [self.titleScrollView setShowsVerticalScrollIndicator:NO];
    [self.titleScrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:self.titleScrollView];
}

#pragma mark --- addContentScrollView

- (void)addContentScrollView {
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + titleScrollViewH, ScreenWidth, ScreenHeight - TitleScrollViewH - 64)];
    self.contentScrollView.delegate = self;
//    [self.contentScrollView setBackgroundColor:[UIColor greenColor]];
    [self.contentScrollView setShowsHorizontalScrollIndicator:NO];
//    [self.contentScrollView setContentSize:CGSizeMake(ScreenWidth * self.demoData.count, 0)];
    [self.contentScrollView setPagingEnabled:YES];
    [self.view addSubview:self.contentScrollView];
}

#pragma mark --- addLable

- (void)addLable {
    CGFloat lbH = 40;
    CGFloat lbW = 70;
    CGFloat lbX = 0;
    CGFloat lbY = 0;
    TitleScrollViewLabel *lb;
    for (int i = 0; i < self.demoData.count; i++) {
        lb = [[TitleScrollViewLabel alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
        [lb setText:self.demoData[i]];
        [self.titleScrollView addSubview:lb];
        lbX += lbW;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lbClick:)];
        [lb setUserInteractionEnabled:YES];
        [lb setTag:i];
        [lb addGestureRecognizer:tap];
    }
    //设置titleScrollView的contentSize
    [self.titleScrollView setContentSize:CGSizeMake(lbW * self.titleScrollView.subviews.count, 0)];
}

- (void)lbClick:(UITapGestureRecognizer *)gr {
    TitleScrollViewLabel *tapLb = (TitleScrollViewLabel*)gr.view;
    CGFloat offSetX = tapLb.tag * ScreenWidth;
    CGFloat offSetY = 0;
    CGPoint offSet = CGPointMake(offSetX, offSetY);
    [self.contentScrollView setContentOffset:offSet animated:YES];
}

#pragma mark --- addContentVC

- (void)addContentVC {
    ContentViewController *contentVC;
    CGFloat colorNum;
    for (int i = 0; i < self.demoData.count; i++) {
        contentVC = [[ContentViewController alloc] init];
        [self addChildViewController:contentVC];
        NSLog(@"%f", colorNum);
        //设置颜色
        [contentVC.view setBackgroundColor:[UIColor colorWithRed:colorNum green:1 - colorNum blue:2 * colorNum alpha:1.0]];
        colorNum += 0.1;
    }
    //设置contentScrollView的contentSize
    [self.contentScrollView setContentSize:CGSizeMake(self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width, 0)];
}

#pragma mark --- UIScrollViewDelegate

//手势导致
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSLog(@"手势导致");
}

//代码导致
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"代码导致");
    //获取index
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    //选中的变形
    TitleScrollViewLabel *lb = (TitleScrollViewLabel*)self.titleScrollView.subviews[index];
    [lb setScale:1.0];
    //未选中的打回原形
    [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index != idx) {
            TitleScrollViewLabel *lb = self.titleScrollView.subviews[idx];
            [lb setScale:0.0];
        }
    }];
    //带动titleScrollView
    CGFloat offSetX = lb.center.x - ScreenWidth / 2;
    CGFloat offSetMaxX = self.titleScrollView.contentSize.width - ScreenWidth;
    if (offSetX < 0) {
        offSetX = 0;
    } else if (offSetX > offSetMaxX) {
        offSetX = offSetMaxX;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];

    //添加子控制器view
    ContentViewController *contentVC = self.childViewControllers[index];
    contentVC.index = index;
    //若子控制器view已加载则不再加载
    if (contentVC.view.superview) {
        return;
    }
    //若没有加载则加载
    [contentVC.view setFrame:self.contentScrollView.bounds];
    NSLog(@"%f", contentVC.view.frame.origin.y);
//    NSLog(@"%f", contentVC.view.frame.size.height);
    [self.contentScrollView addSubview:contentVC.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    //位移量
    CGFloat offset = (scrollView.contentOffset.x - index * ScreenWidth) / ScreenWidth;
    //缩小
    TitleScrollViewLabel *lbsmall = self.titleScrollView.subviews[index];
    [lbsmall setScale:(1 - offset)];
    if (index + 2 <= self.demoData.count) {//注意index 从 0 开始
        //放大
        TitleScrollViewLabel *lbbig = self.titleScrollView.subviews[index + 1];
        [lbbig setScale:offset];
    }
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
