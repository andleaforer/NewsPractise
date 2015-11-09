//
//  ArticleModel.m
//  Practise01
//
//  Created by tarena on 15/11/9.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "ArticleModel.h"
#import "ArticleImageModel.h"

@implementation ArticleModel

- (NSMutableArray *)img {
    if (!_img) {
        _img = [NSMutableArray array];
    }
    return _img;
}

+ (instancetype)initWithDict:(NSDictionary *)dict {
    ArticleModel *articleModel = [[ArticleModel alloc] init];
    articleModel.body = dict[@"body"];
    articleModel.title = dict[@"title"];
    articleModel.source = dict[@"source"];
    //加工出版时间
#warning TODO;
//    articleModel.ptime = [[self alloc] calculatePTime:dict[@"ptime"]];
    articleModel.ptime = dict[@"ptime"];
    //图片
    NSArray *imgArr = dict[@"img"];
    for (NSDictionary *dic in imgArr) {
        ArticleImageModel *model = [ArticleImageModel new];
        model.alt = dic[@"alt"];
        model.pixel = dic[@"pixel"];
        model.src = dic[@"src"];
        model.ref = dic[@"ref"];
        [articleModel.img addObject:model];
    }
    return articleModel;
}

//- (NSString *)calculatePTime:(NSString *)ptime {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @""
//}

@end
