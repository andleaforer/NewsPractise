//
//  ContentHeaderVIew.h
//  Practise01
//
//  Created by Haoran on 15/10/27.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

typedef void(^HVBlock)(NewsModel *);

@interface ContentHeaderView : UIView

@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, copy) HVBlock block;

@end
