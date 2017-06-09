//
//  LoginViewController.m
//  IMHelpDeskDemo
//
//  Created by afanda on 6/2/17.
//  Copyright © 2017 easemob. All rights reserved.
//

#import "LoginViewController.h"
#import "HDHomeViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController
{
    HChatClient *_client;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.usernameTF.text = @"vpjacob";
    self.passwordTF.text = @"111111";
    _client  = [HChatClient sharedClient];
}
- (IBAction)registerBtnClicked:(id)sender {
    HError *err = [_client registerWithUsername:self.usernameTF.text password:self.passwordTF.text];
    if (err == nil) {
        [self showHint:@"注册成功"];
    } else {
        [self showHint:err.errorDescription];
    }
}
- (IBAction)loginBtnClicked:(id)sender {
    [self showHudInView:self.view hint:@"登录中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_client.isLoggedInBefore) {
            [_client logout:YES];
        }
        HError *err = [_client loginWithUsername:self.usernameTF.text password:self.passwordTF.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHud];
            [self showHint:@"登录成功"];
            if (err == nil) {
                HDHomeViewController *home = [HDHomeViewController new];
                [self.navigationController pushViewController:home
                                                     animated:YES];
            } else {
                [self showHint:err.errorDescription];
            }
        });
    });
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
