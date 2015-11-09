//
//  LeftView.m
//  Practise01
//
//  Created by tarena on 15/11/9.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LeftView.h"

@implementation LeftView

+ (instancetype)createLeftViewWith:(CGRect)frame {
    LeftView *leftView = [[self alloc] initWithFrame:frame];
    //添加一个tableView
    
    return leftView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
