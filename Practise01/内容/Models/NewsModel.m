//
//  NewsModel.m
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "NewsModel.h"
#import "Model.h"
#import "Model+CoreDataProperties.h"

@implementation NewsModel

+ (NewsModel *)createNewsModelWithModel:(Model *)model {
    NewsModel *newsModel = [[self alloc] init];
    newsModel.title = model.title;
    newsModel.imgsrc = model.imgsrc;
    newsModel.digest = model.digest;
    newsModel.docid = model.docid;
    newsModel.source = model.source;
    newsModel.ptime = model.ptime;
//    //数组特殊处理，先反归档源数据，再赋值
//    NSMutableArray *imgextra = [NSKeyedUnarchiver unarchiveObjectWithData:model.imgextra];
    newsModel.imgextra = model.imgextra;
    return newsModel;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@, imasrc;%@, digest:%@, imgextra.count:%d, docid:%@, source:%@, ptime:%@", self.title, self.imgsrc, self.digest, self.imgextra.count, self.docid, self.source, self.ptime];
}

@end
