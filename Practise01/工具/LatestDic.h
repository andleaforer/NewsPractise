//
//  LatestDic.h
//  Practise01
//
//  Created by Haoran on 15/11/11.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestDic : NSObject
@property (nonatomic, strong) NSMutableDictionary *Dic;

+ (instancetype)sharedLatestDic;

@end
