//
//  RegisterModel.m
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "RegisterModel.h"
#import <BmobSDK/BmobUser.h>
#import "LoginedUser.h"

@implementation RegisterModel

+ (BOOL)registerWithAccount:(NSString *)account PWD:(NSString *)pwd {
    //判断账户是否已存在：1.不存在，注册成功，返回yes；2.存在，返回no；
    LoginedUser *user = [LoginedUser sharedUser];
    [LoginedUser signOrLoginInbackgroundWithMobilePhoneNumber:account SMSCode:@"1314" andPassword:pwd block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"SignError:%@", error.localizedDescription);
        } else {
            user.username = account;
            user.password = pwd;
        }
    }];
    if (user.username.length == 0) {
        return NO;
    }
    
    return YES;
}

@end
