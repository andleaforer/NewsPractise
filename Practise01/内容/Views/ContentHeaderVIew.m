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
@end

@implementation ContentHeaderView

static NSString *identifier = @"ScrollViewCell";

- (NSMutableArray *)arr {
    if (!_arr) {
#warning TODO;
        _arr = [@[@"1", @"2", @"3", @"4"] mutableCopy];
    }
    return _arr;
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
    [scrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Click!");
}

@end
