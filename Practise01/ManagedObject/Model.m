//
//  Model.m
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "Model.h"
#import "NewsModel.h"

@implementation Model

// Insert code here to add functionality to your managed object subclass
- (void)setModelWithNewsModel:(NewsModel *)newsModel IDStr:(NSString *)idStr {
    self.title = newsModel.title;
    self.imgsrc = newsModel.imgsrc;
    self.digest = newsModel.digest;
    self.docid = newsModel.docid;
    self.source = newsModel.source;
    self.ptime = newsModel.ptime;
    self.list = idStr;
//    //数组特殊处理，先进行归档，再赋值存储
//    NSData *arrData = [NSKeyedArchiver archivedDataWithRootObject:newsModel.imgextra];
    self.imgextra = newsModel.imgextra;
}

@end
