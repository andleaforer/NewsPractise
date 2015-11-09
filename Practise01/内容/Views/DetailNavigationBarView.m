//
//  DetailNavigationBarView.m
//  Practise01
//
//  Created by tarena on 15/11/9.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "DetailNavigationBarView.h"

@implementation DetailNavigationBarView

+ (instancetype)createNavigationBarWith:(CGRect)frame {
    DetailNavigationBarView *nav = [[self alloc] initWithFrame:frame];
    return nav;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
