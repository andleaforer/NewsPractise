//
//  LeftMenuFooterView.m
//  Practise01
//
//  Created by tarena on 15/11/11.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LeftMenuFooterView.h"
#import "MJExtension.h"


@interface LeftMenuFooterView ()
@property (nonatomic, assign, getter=isClickDON) BOOL clickDON;
@property (nonatomic, strong) UIButton *dayOrNightButton;
@property (nonatomic, strong) UIButton *settingButton;
@end

@implementation LeftMenuFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加TestColor
//        self.backgroundColor = [UIColor blueColor];
        self.clickDON = NO;
        //背景色
        self.backgroundColor = [UIColor clearColor];
        //添加夜间/日间模式按钮
        UIButton *dayOrNightButton = [[UIButton alloc] initWithFrame:CGRectMake(44, 22, 44, 55)];
        [dayOrNightButton setImage:[UIImage imageNamed:@"right_navigation_night_new"] forState:UIControlStateNormal];
        [dayOrNightButton setImage:[UIImage imageNamed:@"right_navigation_night_pressed_new"] forState:UIControlStateHighlighted];
        //响应方法
        [dayOrNightButton addTarget:self action:@selector(dayOrNight:) forControlEvents:UIControlEventTouchUpInside];
        self.dayOrNightButton = dayOrNightButton;
        [self addSubview:dayOrNightButton];
        //添加设置按钮
        UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(112, 22, 44, 55)];
        [settingButton setImage:[UIImage imageNamed:@"right_navigation_setting_new"] forState:UIControlStateNormal];
        [settingButton setImage:[UIImage imageNamed:@"right_navigation_setting_pressed_new"] forState:UIControlStateHighlighted];
        //响应方法
        [settingButton addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
        self.settingButton = settingButton;
        [self addSubview:settingButton];
    }
    return self;
}

- (void)dayOrNight:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:(self.isClickDON ? @"right_navigation_night_new" : @"night_right_navigation_day_new")] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:(self.isClickDON ? @"right_navigation_night_pressed_new" : @"night_right_navigation_day_pressed_new")] forState:UIControlStateSelected];
    [self.settingButton setImage:[UIImage imageNamed:(self.isClickDON ? @"right_navigation_setting_new" : @"night_right_navigation_setting_new")] forState:UIControlStateNormal];
    [self.settingButton setImage:[UIImage imageNamed:(self.isClickDON ? @"right_navigation_setting_pressed_new" : @"night_right_navigation_setting_preesed_new")] forState:UIControlStateSelected];
    NSLog(@"%@", self.isClickDON ? @"切换到夜间" : @"切换到日间");
    self.clickDON = !self.clickDON;
    //DKNightVersion
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }
}

- (void)setting:(UIButton *)sender {
    NSLog(@"设置");
#warning TODO;
}

@end
