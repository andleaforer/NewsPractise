//
//  NewsModel.h
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/**
 *  基础属性/HeaderView
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;

/**
 *  TableViewCell
 */
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSArray *imgextra;

/**
 *  DetailView
 */
@property (nonatomic, copy) NSString *docid;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *ptime;

@end
