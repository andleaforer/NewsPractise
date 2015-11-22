//
//  RightMenuView.m
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "RightMenuView.h"

@interface RightMenuView ()
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation RightMenuView

- (void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"RightMenuView" owner:self options:nil];
    [self addSubview:self.view];
}

@end
