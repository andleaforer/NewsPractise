//
//  HttpTool.h
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpTool : AFHTTPSessionManager

+ (HttpTool *)sharedHttpTool;

@end
