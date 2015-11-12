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
#import "LatestDic.h"
#import "Define.h"

@implementation DataTool

+ (void)getDataWithURL:(NSString *)url parameter:(NSDictionary *)para iDStr:(NSString *)idStr refreshCount:(int)count success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //数据库的实体名字为idStr
    if (count <= 0) {
        //1.第一次从数据库拿数据
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
        NSLog(@"Look!____________________________%d", count);
    }
    //获取latestArr
    LatestDic *latestDic = [LatestDic sharedLatestDic];
    if (![latestDic.Dic objectForKey:idStr]) {//没有就创建
        NSMutableArray *latestArr = [NSMutableArray array];
        [latestDic.Dic setValue:latestArr forKey:idStr];
    } else {
        //清空原数据
        [latestDic.Dic[idStr] removeAllObjects];
    }
    //2.从网络获取数据，并存储到COREDATA中
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    [httpTool GET:url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *key = [dic.keyEnumerator nextObject];
        NSArray *tempArr = dic[key];
        NSArray *transTempArr = [NewsModel objectArrayWithKeyValuesArray:tempArr];
        //根据被管理对象上下文判断是否需要进行存入
        NSManagedObjectContext *managedObjectContext = [DataBaseTool managedObjectContext];
        NSSet *latestSet = managedObjectContext.insertedObjects;
        //判断是否存入数据库
        for (NewsModel *newsModel in transTempArr) {
            Model *model = [NSEntityDescription insertNewObjectForEntityForName:ENTITYNAME inManagedObjectContext:managedObjectContext];
            [model setModelWithNewsModel:newsModel IDStr:idStr];
            for (Model *anotherModel in latestSet) {
                if ([model.docid isEqualToString:anotherModel.docid]) {
                    //已存在，不做存入
                    NSLog(@"已存在");
                    [managedObjectContext deleteObject:model];
                } else {
//                    NSLog(@"model:%@", model.docid);
//                    NSLog(@"anotherModel:%@", anotherModel.docid);
                    //不存在，做存入
                    NSLog(@"不存在");
//                    [DataBaseTool insertToDB:model withIDStr:idStr];
                    //存入到managedObjectContext,不删除
                }
            }
            //写入latestArr
            [latestDic.Dic[idStr] addObject:newsModel];
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
