//
//  LoginedUser.h
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <BmobSDK/BmobUser.h>

@interface LoginedUser : BmobUser

+ (instancetype)sharedUser;

@end
