//
//  LoginViewController.m
//  Practise01
//
//  Created by tarena on 15/11/10.
//  Copyright © 2015年 Andleaforer. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterModel.h"
#import "RegisterViewController.h"
#import "LoginedUser.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatar_top;
@property (weak, nonatomic) IBOutlet UITextField *acountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
//判断
@property (nonatomic, assign, getter=isUp) BOOL up;
@property (nonatomic, assign, getter=isDown) BOOL down;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.up = NO;
    self.down = YES;
    //设立广播
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upView:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downView:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)upView:(NSNotification *)noti {
    //获取键盘出现信息
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
//    NSTimeInterval duration = [dict[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    //动画
    [UIView animateWithDuration:1 delay:0 options:option animations:^{
        if (self.isDown) {
            self.avatar_top.constant -= 20;
            self.top.constant -= 40;
            self.bottom.constant += 40;
            self.down = NO;
            self.up = YES;
        }
    } completion:nil];
    [self.view layoutIfNeeded];
}

- (void)downView:(NSNotification *)noti {
    //获取键盘出现信息
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
//    NSTimeInterval duration = [dict[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    //动画
    [UIView animateWithDuration:1 delay:0 options:option animations:^{
        if (self.isUp) {
            self.avatar_top.constant += 20;
            self.top.constant += 40;
            self.bottom.constant -= 40;
            self.up = NO;
            self.down = YES;
        }
    } completion:nil];
    [self.view layoutIfNeeded];
}

- (void)viewWillDisappear:(BOOL)animated {
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)regist:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    vc.block = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)login:(id)sender {
    [LoginedUser loginInbackgroundWithAccount:self.acountTextField.text andPassword:self.passwordTextField.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"LoginError:%@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alertView show];
        } else {
            LoginedUser *Luser = [LoginedUser sharedUser];
            Luser.username = user.username;
            Luser.password = user.password;
            Luser.login = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoginStatus" object:nil];
            });
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
- (IBAction)forgetPWD:(id)sender {
    NSLog(@"忘记密码");
}
- (IBAction)acountTF:(id)sender {
    [self.acountTextField resignFirstResponder];
    [self.passwordTextField becomeFirstResponder];
}
- (IBAction)pwdTF:(id)sender {
    [self.passwordTextField resignFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
