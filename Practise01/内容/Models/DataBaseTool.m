//
//  DataBaseTool.m
//  Practise01
//
//  Created by tarena on 15/11/6.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "DataBaseTool.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Model+CoreDataProperties.h"
#import "Model.h"
#import "NewsModel.h"

#define ENTITYNAME @"Model"

@interface DataBaseTool()
@end

@implementation DataBaseTool
//获取老板
+ (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = delegate.managedObjectContext;
    return managedObjectContext;
}

//查询
+ (NSArray *)queryModelWithIDStr:(NSString *)idStr {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    //1.配置
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:ENTITYNAME];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"list=%@", idStr];
    request.predicate = predicate;
    //2.执行操作
    NSError *error = nil;
    NSArray *tempArr = [NSArray arrayWithArray:[managedObjectContext executeFetchRequest:request error:&error]];
    if (error) {
        NSLog(@"QueryError:%@", error.userInfo);
        return nil;
    }
    //3.返回结果数组
    return tempArr;
}

//插入
+ (void)insertToDB:(NewsModel *)newModel withIDStr:(NSString *)idStr {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    //1.创建实体
    Model *newNewsModel = [NSEntityDescription insertNewObjectForEntityForName:ENTITYNAME inManagedObjectContext:managedObjectContext];
    //2.赋值
    [newNewsModel setModelWithNewsModel:newModel IDStr:idStr];
#pragma mark - save at the moment when application enter background
//    //3.保存
//    NSError *error = nil;
//    if (![managedObjectContext save:&error]) {
//        NSLog(@"InsertError:%@", error.userInfo);
//    }
}

//更新

//删除
+ (void)deleteModelWithIDStr:(NSString *)idStr {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    //1.配置
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:ENTITYNAME];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"list=%@", idStr];
    request.predicate = predicate;
    //2.执行操作
    NSError *error = nil;
    NSArray *tempArr = [NSArray arrayWithArray:[managedObjectContext executeFetchRequest:request error:&error]];
    if (error) {
        NSLog(@"QueryError:%@", error.userInfo);
        return;
    }
    //3.删除操作
    for (Model *model in tempArr) {
        [managedObjectContext deleteObject:model];
    }
#pragma mark - save at the moment when application enter background
//    //4.保存操作
//    [managedObjectContext save:&error];
//    if (error) {
//        NSLog(@"SaveError:%@", error.userInfo);
//    }
}

















@end
