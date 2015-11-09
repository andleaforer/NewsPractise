//
//  DataTool.h
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject
+ (void)getDataWithURL:(NSString *)url parameter:(NSDictionary *)para iDStr:(NSString *)idStr refreshCount:(int)count success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)getArticleWithURL:(NSString *)url paramater:(NSDictionary *)para iDStr:(NSString *)idStr success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
