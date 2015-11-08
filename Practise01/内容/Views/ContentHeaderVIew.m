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
#import "NewsModel.h"

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

- (void)setArr:(NSMutableArray *)arr {
    _arr = arr;
    //添加定时器
    if (arr.count > 0) {//获取了数据才进行各项内容刷新
        if (self.timer == nil) {
            [self addTimer];//重新添加定时器
        }
        //转换对象
        NewsModel *newsModel = (NewsModel*)arr[0];
        self.titleLabel.text = newsModel.title;
        [self.scrollView reloadData];
        self.pageControl.numberOfPages = arr.count;
    }
}

#pragma mark --- addTimer
- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
}

- (void)nextPage {
    //获取当前indexPath
    NSIndexPath *currentIndexPath = [self IndexPathReset];
    //计算下一个indexPath
    NSInteger item = currentIndexPath.item;
    NSInteger section = currentIndexPath.section;
    item++;
    if (item == self.arr.count) {
        item = 0;
        section++;
    }
    //滑动操作
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    [self.scrollView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

- (NSIndexPath *)IndexPathReset {
    NSIndexPath *currentIndexPath = [[self.scrollView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxCount / 2];
    [self.scrollView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    return currentIndexPathReset;
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
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
//    [scrollView setBackgroundColor:[UIColor grayColor]];
    self.scrollView = scrollView;
    [self addSubview:scrollView];
}

#pragma mark --- addTitleLabel
- (void)addTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TitleLBMargin, self.scrollView.bounds.size.height, ScreenWidth - TitleLBMargin * 2, TitleLbH)];
//    [titleLabel setBackgroundColor:[UIColor redColor]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
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
    return MaxCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContentHeaderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NewsModel *newsModel = self.arr[indexPath.row];
    cell.newsModel = newsModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
#warning TODO!
    NSLog(@"Click!");
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self IndexPathReset];
}

//滑动关联
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    NSInteger trueIndex = index % 4 ;
    self.pageControl.currentPage = trueIndex;
    NewsModel *newsModel = (NewsModel*)self.arr[trueIndex];
    self.titleLabel.text = newsModel.title;
}

@end
