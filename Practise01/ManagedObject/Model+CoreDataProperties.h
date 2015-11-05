//
//  Model+CoreDataProperties.h
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Model (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *imgsrc;
@property (nullable, nonatomic, retain) NSString *digest;
@property (nullable, nonatomic, retain) id imgextra;
@property (nullable, nonatomic, retain) NSString *docid;
@property (nullable, nonatomic, retain) NSString *source;
@property (nullable, nonatomic, retain) NSString *ptime;
@property (nullable, nonatomic, retain) NSString *list;

@end

NS_ASSUME_NONNULL_END
