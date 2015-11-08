//
//  ContentHeaderViewCell.m
//  Practise01
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentHeaderViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ContentHeaderViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addImage];
    }
    return self;
}

- (void)addImage {
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.png"];
    UIImageView *imageView = [UIImageView new];
    imageView.image = placeholderImage;
    [imageView setFrame:self.bounds];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setClipsToBounds:YES];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)setNewsModel:(NewsModel *)newsModel {
    NSURL *imageURL = [NSURL URLWithString:newsModel.imgsrc];
    [self.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

@end
