//
//  ContentViewCell.m
//  Practise01
//
//  Created by tarena on 15/10/31.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ContentViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"

@interface ContentViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ContentViewCell

- (void)setNewsModel:(NewsModel *)newsModel {
    _newsModel = newsModel;
    self.titleLabel.text = newsModel.title;
    self.subtitleLabel.text = newsModel.source;
    NSURL *imageURL = [NSURL URLWithString:newsModel.imgsrc];
    [self.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
