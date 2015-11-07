//
//  ContentHeaderViewCell.m
//  Practise01
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentHeaderViewCell.h"

@implementation ContentHeaderViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addImage];
    }
    return self;
}

- (void)addImage {
    UIImageView *imageView = [UIImageView new];
    [imageView setFrame:self.bounds];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setClipsToBounds:YES];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)setNewsModel:(NewsModel *)newsModel {
    _newsModel = newsModel;
}

@end
