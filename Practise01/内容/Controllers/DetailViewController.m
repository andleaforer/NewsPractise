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
#import "DataTool.h"
#import "ArticleModel.h"
#import "ArticleImageModel.h"
#import "SVProgressHUD.h"
#import "DetailNavigationBarView.h"
#import "DataBaseTool.h"
#import "AppDelegate.h"

#pragma ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@interface DetailViewController () <UIWebViewDelegate, UIScrollViewDelegate, ISSContent>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ArticleModel *articleModel;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置back按钮
//    self.navigationItem.hidesBackButton = YES;
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //添加navigationBar的分享按钮
    [self setupSharedBTN];
    //添加webView
    [self setupWebView];
    //添加底部的分享按钮
    
    //DKNight
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
//        cell.normalBackgroundColor = [UIColor whiteColor];
//        cell.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.webView.normalBackgroundColor = [UIColor whiteColor];
        self.webView.nightBackgroundColor = UIColorFromRGB(0x343434);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    //1.通信连接
    [self requestData];
//    //2.隐藏navigationBar
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupShareBTN
- (void)setupSharedBTN {
    DetailNavigationBarView *detailNav = [DetailNavigationBarView createNavigationBarWith:CGRectMake(0, 0, ScreenWidth, 64)];
    /*
    //返回按钮
    UIButton *backBTN = [[UIButton alloc] init];
    UIImage *normalImage = [UIImage imageNamed:@"icon_back"];
    UIImage *highlightedImage = [UIImage imageNamed:@"icon_back_highlighted"];
    [backBTN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBTN setBackgroundImage:normalImage forState:UIControlStateNormal];
//    [backBTN setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    CGRect frame = CGRectMake(12.5, 64 - normalImage.size.height, normalImage.size.width, normalImage.size.height);
    backBTN.frame = frame;
    [detailNav addSubview:backBTN];
     */
    //收藏按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(0, 0, 33, 33);
    [btn1 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"icon_bottom_star"] forState:UIControlStateNormal];
    UIBarButtonItem *markBTN = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    //分享按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(0, 0, 33, 33);
    [btn2 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setImage:[UIImage imageNamed:@"icon_bottom_share"] forState:UIControlStateNormal];
    UIBarButtonItem *shareBTN = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItems = @[shareBTN, markBTN];
    [self.view addSubview:detailNav];
}

- (void)action:(UIButton *)sender {
    NSLog(@"shared!");
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
//    [container setIPhoneContainerWithViewController:sender];
    
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (void)save {
    [DataBaseTool insertToDB:self.newsModel withIDStr:@"Mark"];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = delegate.managedObjectContext;
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"SaveError:%@", error.userInfo);
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shared {
    NSLog(@"tap the rightBTN");
}

#pragma mark - setupWebView
- (void)setupWebView {
#warning TODO; 判断网络状态
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    webView.delegate = self;
    webView.scrollView.delegate = self;
    self.webView = webView;
    [self.view insertSubview:webView atIndex:1];
}

- (void)requestData {
#warning TODO; 添加加载控件，改善UX
    if (!self.articleModel) {
        [SVProgressHUD show];
        //1.连接网络获取数据
        NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
        [DataTool getArticleWithURL:url paramater:nil iDStr:@"" success:^void(id responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            ArticleModel *articleModel = [ArticleModel initWithDict:dic[self.newsModel.docid]];
            self.articleModel = articleModel;
            //2.加载数据
            [self loadData];
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            NSLog(@"DetailViewController requestData: Error:%@", error.userInfo);
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)loadData {
    NSMutableString *html = [NSMutableString string];
    //1.基本格式
    [html appendString:@"<html>"];
    [html appendFormat:@"<head><link rel = \"stylesheet\" href = \"%@\">", [[NSBundle mainBundle] URLForResource:@"detail.css" withExtension:nil]];
    [html appendString:@"<body>"];
    [html appendString:[self addBody]];
    [html appendString:@"</body>"];
    [html appendString:@"</head>"];
    [html appendString:@"</html>"];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)addBody {
    NSMutableString *body = [NSMutableString string];
    //1.标题
    [body appendFormat:@"<div class = \"title\">%@</div>", self.articleModel.title];
    //2.时间
    [body appendFormat:@"<div class = \"time\">%@ &nbsp;&nbsp %@</div>", self.articleModel.ptime, self.articleModel.body];
    //3.图片
    NSArray *imgArr = self.articleModel.img;
    for (ArticleImageModel *imageModel in imgArr) {
        NSMutableString *imgHtml = [NSMutableString string];
        //1.计算图片宽度、高度
        NSArray *pixel = [imageModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject] floatValue];
        CGFloat height = [[pixel lastObject] floatValue];
        //2.进行缩放
        CGFloat maxwidth = [UIScreen mainScreen].bounds.size.width * 0.9;
        if (width > maxwidth) {
            height = maxwidth / width * height;
            width = maxwidth;
        }
        NSString *onload = @"this.onclick = function() {"" window.location.href = 'sx:src = ' + this.src;""};";
        [imgHtml appendFormat:@"<div class = \"img-parent\"><img onload = \"%@\", width = \"%f\", height = \"%f\", src = \"%@\"></div>", onload, width, height, imageModel.src];
#warning TEST; 尝试不替换ref - 结果，图片不会插入正文中，只会出现在正文末尾!!!!
        [body replaceOccurrencesOfString:imageModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
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
