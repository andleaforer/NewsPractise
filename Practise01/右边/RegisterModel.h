//
//  RegisterModel.h
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

+ (BOOL)registerWithAccount:(NSString *)account PWD:(NSString *)pwd;

@end
