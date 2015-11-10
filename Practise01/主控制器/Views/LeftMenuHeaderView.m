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
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
}

- (void)login:(UIButton *)sender {
#warning TODO;
    NSLog(@"登录");
}

@end
