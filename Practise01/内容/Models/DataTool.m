//
//  DataTool.m
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "DataTool.h"
#import "HttpTool.h"
#import "DataBaseTool.h"
#import "NewsModel.h"
#import "NSObject+MJKeyValue.h"
#import "Model+CoreDataProperties.h"
#import "Model.h"

@implementation DataTool

+ (void)getDataWithURL:(NSString *)url parameter:(NSDictionary *)para iDStr:(NSString *)idStr refreshCount:(int)count success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //数据库的实体名字为idStr
    if (count <= 1) {
        //1.如果COREDATA有数据，则从数据库取值
        NSArray *tempDBArr = [DataBaseTool queryModelWithIDStr:idStr];
        NSMutableArray *transTempArr = [NSMutableArray array];
        if (tempDBArr.count > 0) {
            for (Model *model in tempDBArr) {
                NewsModel *newsModel = [NewsModel createNewsModelWithModel:model];
                [transTempArr addObject:newsModel];
            }
            if (success) {
                success(transTempArr);
            }
            return;
        }
    }
    //2.从网络获取数据，并存储到COREDATA中
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    [httpTool GET:url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *key = [dic.keyEnumerator nextObject];
        NSArray *tempArr = dic[key];
        NSArray *transTempArr = [NewsModel objectArrayWithKeyValuesArray:tempArr];
        //存入数据库
        for (NewsModel *newsModel in transTempArr) {
            [DataBaseTool insertToDB:newsModel withIDStr:idStr];
        }
        //返回结果
        if (success) {
            success(transTempArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getArticleWithURL:(NSString *)url paramater:(NSDictionary *)para iDStr:(NSString *)idStr success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //不做数据库存储操作
    //1.从网络获取数据
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    [httpTool GET:url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

































@end
