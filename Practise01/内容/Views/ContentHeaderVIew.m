//
//  ContentHeaderVIew.m
//  Practise01
//
//  Created by Haoran on 15/10/27.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentHeaderVIew.h"
#import "Define.h"
#import "ContentHeaderViewCell.h"

#define MaxCount 100
#define TitleLBMargin 11
#define PageControlW 100
#define HeaderViewH  230
#define TitleLbH 30

@interface ContentHeaderView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ContentHeaderView

static NSString *identifier = @"ScrollViewCell";

- (void)setArr:(NSArray *)arr {
    _arr = arr;
    //添加定时器
    if (arr.count > 0) {//获取了数据才进行各项内容刷新
        if (self.timer == nil) {
            [self addTimer];//重新添加定时器
        }
        self.pageControl.numberOfPages = arr.count;
        self.titleLabel.text = arr[0];
        [self.scrollView reloadData];
    }
}

static int count = 0;

#pragma mark --- addTimer
- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
}

- (void)nextPage {
    NSLog(@"-----");
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加scrollView
        [self addScrollView];
        //添加titleLabel
        [self addTitleLabel];
        //添加pageControl
        [self addPageControl];
    }
    return self;
}

#pragma mark --- addScrollView
- (void)addScrollView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell的大小
    [flowLayout setItemSize:CGSizeMake(ScreenWidth, HeaderViewH - titleLbH)];
    //设置cell之间的间距
    [flowLayout setMinimumLineSpacing:0];
    //设置滑动方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //创建scrollView
    UICollectionView *scrollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, HeaderViewH - TitleLbH) collectionViewLayout:flowLayout];
    //注册cell
    [scrollView registerClass:[ContentHeaderViewCell class] forCellWithReuseIdentifier:identifier];
    //自定义设置
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    [scrollView setDataSource:self];
    [scrollView setBackgroundColor:[UIColor grayColor]];
    self.scrollView = scrollView;
    [self addSubview:scrollView];
}

#pragma mark --- addTitleLabel
- (void)addTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TitleLBMargin, self.scrollView.bounds.size.height, ScreenWidth - TitleLBMargin * 2, TitleLbH)];
    [titleLabel setBackgroundColor:[UIColor redColor]];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
}

#pragma mark --- addPageControl
- (void)addPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, PageControlW, TitleLbH)];
    [pageControl setCenter:CGPointMake(ScreenWidth / 2, self.scrollView.bounds.size.height - TitleLbH)];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    pageControl.numberOfPages = self.arr.count;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark --- UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.arr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MaxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContentHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Click!");
}

@end
