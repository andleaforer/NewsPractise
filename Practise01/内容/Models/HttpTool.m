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
        config.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
        httpTool = [[HttpTool alloc] initWithBaseURL:url sessionConfiguration:config];
        httpTool.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return httpTool;
}

#warning 在发动请求的 requestHeaderField 中加入 If-NoneMatch 或者 If-Modified-Since 字段，和服务端数据进行比较是否有更新，有更新则返回body，没有的话就在responseHeaders中告知使用缓存。
//- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler {
//    static NSString *deviceId;
//    if (!deviceId) {
//        deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    }
//    NSLog(@"DeviceID:%@", deviceId);
//    NSMutableURLRequest *req = (NSMutableURLRequest *)request;
//    NSString *reqId = [NSString stringWithFormat:@"%@+%@", deviceId, [[NSUUID UUID] UUIDString]];
//    [req setValue:reqId forHTTPHeaderField:@"If-Modified-Since"];
//    return [super dataTaskWithRequest:req completionHandler:completionHandler];
//}

@end
