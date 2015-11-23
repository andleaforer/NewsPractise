//
//  LoginedUser.m
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LoginedUser.h"

@implementation LoginedUser

static LoginedUser* user = nil;
+ (instancetype)sharedUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
        user.login = NO;
    });
    return user;
}

@end
