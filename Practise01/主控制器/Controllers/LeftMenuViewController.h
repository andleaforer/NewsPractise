//
//  LeftMenuViewController.h
//  Practise01
//
//  Created by tarena on 15/11/10.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NewsController,
    MarkController,
    CommentController,
    RadioController
} ChildController;

@protocol LeftMenuViewControllerDelegate <NSObject>

-(void)changeViewToTargetController:(NSInteger)index;

@end

@interface LeftMenuViewController : UITableViewController

@property (nonatomic, strong) id<LeftMenuViewControllerDelegate> delegate;

@end
