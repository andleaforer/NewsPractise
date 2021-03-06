//
//  CustomURLCache.m
//  Practise01
//
//  Created by tarena on 15/11/17.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "CustomURLCache.h"

static NSString * const CustomURLCacheExpirationKey = @"CustomURLCacheExpiration";
static NSTimeInterval const CustomURLCacheExpirationInterval = 240;

@implementation CustomURLCache

+ (instancetype)standardURLCache {
    static CustomURLCache *_standardURLCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _standardURLCache = [[CustomURLCache alloc] initWithMemoryCapacity:(2 * 1024 * 1024) diskCapacity:(100 * 1024 * 1024) diskPath:nil];
    });
    return _standardURLCache;
}

#pragma mark - NSURLCache

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    NSLog(@"CacheResponseForRequest");
    NSCachedURLResponse *cachedResponse = [super cachedResponseForRequest:request];
    if (cachedResponse) {
        NSDate *cacheDate = cachedResponse.userInfo[CustomURLCacheExpirationKey];
        NSDate *cacheExpirationDate = [cacheDate dateByAddingTimeInterval:CustomURLCacheExpirationInterval];
        if ([cacheExpirationDate compare:[NSDate date] ] == NSOrderedAscending) {
            [self removeCachedResponseForRequest:request];
            NSLog(@"LOG____________移除过期缓存!");
            return nil;
        }
    }
    return cachedResponse;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
    NSLog(@"storeCacheResponse");
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:cachedResponse.userInfo];
    if ([userInfo objectForKey:CustomURLCacheExpirationKey]) {
        NSLog(@"LOG______________直接返回!");
        return;
    }
    NSLog(@"UserInfo:%@", userInfo);
    userInfo[CustomURLCacheExpirationKey] = [NSDate date];
    NSCachedURLResponse *modifiedCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:userInfo storagePolicy:cachedResponse.storagePolicy];
    [super storeCachedResponse:modifiedCachedResponse forRequest:request];
}

@end
