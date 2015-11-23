//
//  LeftMenuHeaderView.h
//  Practise01
//
//  Created by tarena on 15/11/10.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftMenuBlock)(void);

@interface LeftMenuHeaderView : UIView
@property (nonatomic, copy) LeftMenuBlock block;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *accountLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
