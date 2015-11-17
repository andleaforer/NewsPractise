//
//  AppDelegate.m
//  Practise01
//
//  Created by tarena on 15/10/21.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "LatestDic.h"
#import "CustomURLCache.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
//    [_window setRootViewController:na];
//    [_window makeKeyAndVisible];
    //设置后台获取网络标识indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //获取LatestDic
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"LatestDic"];
    LatestDic *latestDic = [LatestDic sharedLatestDic];
    latestDic.Dic = [dic mutableCopy];
    //设置共享URLCache
    CustomURLCache *sharedCache = [CustomURLCache standardURLCache];
    [NSURLCache setSharedURLCache:sharedCache];
    //设置ShareSDK
//    ShareSDK registerApp:@"c4e0099651f2" activePlatforms:@[@(SSDKPlatformSubTypeQZone), @(SSDKPlatformSubTypeQQFriend), @(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline), @(SSDKPlatformTypeMail)] onImport:nil onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//        switch (platformType) {
//            case SSDKPlatformSubTypeQZone:{
//                <#statements#>
//                break;
//            }
//            case SSDKPlatformSubTypeQQFriend:{
//                <#statements#>
//                break;
//            }
//            case SSDKPlatformSubTypeWechatSession:{
//                <#statements#>
//                break;
//            }
//            case SSDKPlatformSubTypeWechatTimeline:{
//                <#statements#>
//                break;
//            }
//            case SSDKPlatformTypeMail:{
//                <#statements#>
//                break;
//            }
//        }
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
#pragma mark - do save/delete at DATABASE
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Save Error:%@", error.userInfo);
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
    LatestDic *latestDic = [LatestDic sharedLatestDic];
#warning 注意，NSUserDefaults存储mutable集合类对象，会出错，要转化为immutable
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:latestDic.Dic];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"LatestDic"];
#pragma mark - do save/delete at DATABASE
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Save Error:%@", error.userInfo);
    }
}

#pragma mark - COREDATA
//老板
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //绑定
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    return _managedObjectContext;
}

//秘书
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    //1.绑定员工
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *storePath = [documentPath stringByAppendingPathComponent:@"DB.sqlite"];
    NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    NSError *error = nil;
    //2.指定工作规章
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Error:%@", error.userInfo);
    }
    return _persistentStoreCoordinator;
}

//员工
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"DB" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    return _managedObjectModel;
}































@end
