//
//  ContentViewCell.h
//  Practise01
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface ContentViewCell : UITableViewCell
@property (nonatomic, strong) NewsModel *newsModel;
@end
