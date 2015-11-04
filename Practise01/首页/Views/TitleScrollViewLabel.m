//
//  TitleScrollViewLabel.m
//  Practise01
//
//  Created by Haoran on 15/10/24.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "TitleScrollViewLabel.h"

@implementation TitleScrollViewLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        self.scale = 0.0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [self setTextColor:[UIColor colorWithRed:_scale green:0.0 blue:0.0 alpha:1.0]];
    CGFloat minScale = 0.7;
    CGFloat transScale = minScale + (1 - minScale) * _scale;
    [self setTransform:CGAffineTransformMakeScale(transScale, transScale)];
}

@end
