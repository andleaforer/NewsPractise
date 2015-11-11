//
//  LatestDic.m
//  Practise01
//
//  Created by Haoran on 15/11/11.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LatestDic.h"

@implementation LatestDic

static LatestDic *latestDic;
+ (instancetype)sharedLatestDic {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        latestDic = [[self alloc] init];
    });
    return latestDic;
}

- (instancetype)init {
    if (self = [super init]) {
        self.Dic = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
