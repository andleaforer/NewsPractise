//
//  RegisterViewController.h
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissBlock)(void);

@interface RegisterViewController : UIViewController
@property (nonatomic, copy) DismissBlock block;
@end
