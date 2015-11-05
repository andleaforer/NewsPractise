//
//  ContentHeaderViewCell.h
//  Practise01
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface ContentHeaderViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NewsModel *newsModel;

@end
