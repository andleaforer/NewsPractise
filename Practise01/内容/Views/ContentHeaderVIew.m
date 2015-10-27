//
//  ContentHeaderVIew.m
//  Practise01
//
//  Created by Haoran on 15/10/27.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentHeaderVIew.h"
#import "Define.h"

@interface ContentHeaderVIew () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ContentHeaderVIew

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加scrollView
        //添加titleLabel
        //添加pageControl
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
    UICollectionView *scrollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, HeaderViewH - titleLbH) collectionViewLayout:flowLayout];
    //注册cell
#warning TODO;
    //自定义设置
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    [scrollView setDataSource:self];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

@end
