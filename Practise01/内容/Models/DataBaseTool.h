//
//  DataBaseTool.h
//  Practise01
//
//  Created by tarena on 15/11/6.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NewsModel;
@class DataBaseTool;
@class Model;

@interface DataBaseTool : NSObject

+ (NSManagedObjectContext *)managedObjectContext;

//查询
+ (NSArray *)queryModelWithIDStr:(NSString *)idStr;

//插入
+ (void)insertToDB:(NewsModel *)newModel withIDStr:(NSString *)idStr;

//更新
//写入PList
+ (void)writeToPlistWithIDStr:(NSString *)idStr;

//删除
+ (void)deleteModelWithIDStr:(NSString *)idStr;
+ (void)deleteAllModel;
@end
