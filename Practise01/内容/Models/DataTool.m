//
//  DataTool.m
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "DataTool.h"
#import "HttpTool.h"

@implementation DataTool

+ (void)getDataWithURL:(NSString *)url parameter:(NSDictionary *)para iDStr:(NSString *)idStr success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //数据库的实体名字为idStr
    //1.如果COREDATA有数据，则从数据库取值
#warning TODO;
    //2.从网络获取数据，并存储到COREDATA中
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    [httpTool GET:url parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *key = [dic.keyEnumerator nextObject];
        NSArray *tempArr = dic[key];
        //存入数据库
        //返回结果
        if (success) {
            success(tempArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
