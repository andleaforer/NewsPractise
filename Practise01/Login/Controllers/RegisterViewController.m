//
//  RegisterViewController.m
//  Practise01
//
//  Created by tarena on 15/11/22.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginedUser.h"
#import <BmobSDK/BmobSMS.h>

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *smsCode;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getSmscode:(id)sender {
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneNumber.text andTemplate:nil resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"SMSRequestError:%@", error.localizedDescription);
        } else {
            NSLog(@"SMSNumber:%d", number);
        }
    }];
}
- (IBAction)regiser:(id)sender {
    //判断账户是否已存在：1.不存在，注册成功，返回yes；2.存在，返回no；
    LoginedUser *user = [LoginedUser sharedUser];
    [LoginedUser signOrLoginInbackgroundWithMobilePhoneNumber:self.phoneNumber.text SMSCode:self.smsCode.text andPassword:self.password.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"SignError:%@", error.localizedDescription);
        } else {
            user.username = self.phoneNumber.text;
            user.password = self.password.text;
            //跳转主界面
            [self dismiss:nil];
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
