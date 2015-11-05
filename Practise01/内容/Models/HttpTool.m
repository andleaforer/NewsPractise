//
//  HttpTool.m
//  Practise01
//
//  Created by tarena on 15/11/5.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

static HttpTool* httpTool = nil;
+ (HttpTool *)sharedHttpTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        httpTool = [[HttpTool alloc] initWithBaseURL:url sessionConfiguration:config];
        httpTool.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return httpTool;
}

@end
