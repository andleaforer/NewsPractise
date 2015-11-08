//
//  DetailViewController.m
//  Practise01
//
//  Created by Haoran on 15/11/8.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "DetailViewController.h"
#import "Define.h"
#import "NewsModel.h"

@interface DetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加navigationBar的分享按钮
    [self setupSharedBTN];
    //添加webView
    [self setupWebView];
    //添加底部的分享按钮
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupShareBTN
- (void)setupSharedBTN {
    //分享按钮
    UIBarButtonItem *rightBTN = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shared)];
    //适配按钮
    UIBarButtonItem *spaceBTN = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceBTN.width = 12.5;
    self.navigationItem.rightBarButtonItems = @[spaceBTN,rightBTN];
}

- (void)shared {
    NSLog(@"tap the rightBTN");
}

#pragma mark - setupWebView
- (void)setupWebView {
#warning TODO; 判断网络状态
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    self.webView = webView;
    [self.view insertSubview:webView atIndex:1];
}


/*
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
*/
 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
