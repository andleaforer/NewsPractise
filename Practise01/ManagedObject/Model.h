//
//  Model.h
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (void)setModelWithNewsModel:(NewsModel *)newsModel IDStr:(NSString *)idStr;

@end

NS_ASSUME_NONNULL_END

#import "Model+CoreDataProperties.h"
