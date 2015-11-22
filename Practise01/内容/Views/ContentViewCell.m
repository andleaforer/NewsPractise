//
//  ContentViewCell.m
//  Practise01
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentViewCell.h"
#import "UIImageView+WebCache.h"
#import "NewsModel.h"

@interface ContentViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation ContentViewCell

@synthesize imageView = _imageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNewsModel:(NewsModel *)newsModel {
    //DKNight
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
//        cell.normalBackgroundColor = [UIColor whiteColor];
//        cell.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.titleLabel.normalTextColor = UIColorFromRGB(0x343434);
        self.titleLabel.nightTextColor = [UIColor whiteColor];
    }];
    self.titleLabel.text = newsModel.title;
    self.subtitleLabel.text = newsModel.source;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
