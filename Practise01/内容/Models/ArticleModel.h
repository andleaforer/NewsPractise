//
//  ArticleModel.h
//  Practise01
//
//  Created by tarena on 15/11/9.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *ptime;
@property (nonatomic, strong) NSMutableArray *img;

+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
