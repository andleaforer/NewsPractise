//
//  TableViewCellView.m
//  Practise01
//
//  Created by tarena on 15/11/10.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "TableViewCellView.h"

@implementation TableViewCellView

- (instancetype)initWithImageSrc:(NSString *)imageSrc title:(NSString *)title {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        //Frame
        self.frame = CGRectMake(44, 2, 100, 40);
        //图标
        UIImage *image = [UIImage imageNamed:imageSrc];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 0, 40, 40);
        [self addSubview:imageView];
        //TitleLabel
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 60, 40)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    return self;
}

@end