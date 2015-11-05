//
//  AppDelegate.h
//  Practise01
//
//  Created by tarena on 15/10/21.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//老板
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//秘书
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//员工
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

