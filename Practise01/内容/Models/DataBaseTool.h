//
//  DataBaseTool.h
//  Practise01
//
//  Created by tarena on 15/11/6.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsModel;

@interface DataBaseTool : NSObject

//查询
+ (NSArray *)queryModelWithIDStr:(NSString *)idStr;

//插入
+ (void)insertToDB:(NewsModel *)newModel withIDStr:(NSString *)idStr;

//更新

//删除
+ (void)deleteModelWithIDStr:(NSString *)idStr;
+ (void)deleteAllModel;
@end
