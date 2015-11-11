//
//  LeftMenuHeaderView.m
//  Practise01
//
//  Created by tarena on 15/11/10.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LeftMenuHeaderView.h"
#import "LoginViewController.h"

@implementation LeftMenuHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置背景颜色:clearColor
        self.backgroundColor = [UIColor clearColor];
        //添加登录button
        [self addLoginButton];
        //添加底部灰线
        [self addBottomLine];
    }
    return self;
}

- (void)addLoginButton {
    UIButton *loginBTN = [[UIButton alloc] initWithFrame:CGRectMake(22, 44, 156, 156)];
    //设置背景图片
    [loginBTN setImage:[UIImage imageNamed:@"right_navigation_head_default"] forState:UIControlStateNormal];
    [loginBTN setImage:[UIImage imageNamed:@"right_navigation_head_default"] forState:UIControlStateHighlighted];
    //响应方法
    [loginBTN addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    //添加到父视图中
    [self addSubview:loginBTN];
}

- (void)addBottomLine {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 199, 168, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
}

- (void)login:(UIButton *)sender {
    self.block();
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //放大
        sender.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        sender.transform = CGAffineTransformIdentity;
    }];
}

@end
