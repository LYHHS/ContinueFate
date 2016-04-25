//
//  ViewController.m
//  ContinueFate
//
//  Created by 刘金发 on 16/4/16.
//  Copyright © 2016年 XuYuan. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+NJ.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化一个bool格式的单例化全局标量来表示是否成功执行了注册  默认为否
    [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@NO];
//    //显示加载
//    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
//    //加载完成
//    [MBProgressHUD hideHUDForView:self.view];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登录
- (IBAction)loginAction:(id)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    if (username.length == 0 || password.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
        
    }
    [self loginWithUsername:username addpassword:password];
}

//记忆用户名
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![[Utilities getUserDefaults:@"Username"] isKindOfClass:[NSNull class]]) {
        //如果有记忆就把记忆显示在用户名文本输入框中
        _usernameTF.text = [Utilities getUserDefaults:@"Username"];
    }
    
}
//每次这个页面出现的时候都会调用这个方法，并且时机点是页面已然出现以后
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if ([[[StorageMgr singletonStorageMgr] objectForKey:@"SignUpSuccessfully"] boolValue]) {
        //先将SignUpSuccessfully这个单例化全局变量中的folg删除以保证
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"SignUpSuccessfully"];
        //初始化一个bool格式的单例化全局标量来表示是否成功执行了注册  默认为否
        [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@NO];
        //在单例化全局变量中提取用户名和密码
        NSString *username =[[StorageMgr singletonStorageMgr] objectForKey:@"Username"];
        NSString *password =[[StorageMgr singletonStorageMgr] objectForKey:@"Password"];
        
        //清除用完的用户名和密码
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Username"];
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Password"];
        //执行自动登录
        [self loginWithUsername:username addpassword:password];
    }
    
}
-(void)loginWithUsername:(NSString *)username addpassword:(NSString *)password {
    //菊花
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    self.navigationController.view.self.userInteractionEnabled = NO;
    NSDictionary *parameters = @{@"code":username,@"pwd":password,@"loginType":@1};
    [RequestAPI postURL:@"/login" withParameters:parameters success:^(id responseObject) {
        [avi stopAnimating];
        self.navigationController.view.self.userInteractionEnabled = YES;
        if ([responseObject[@"resultFlag"]integerValue] == 8001) {
                NSLog(@"登陆成功");
            NSDictionary *dic = responseObject[@"result"];
            NSArray *Arr =dic[@"models"];
            NSDictionary *models = Arr[0] ;
            NSLog(@"Arr  ==%@",Arr);
            [[StorageMgr singletonStorageMgr]removeObjectForKey:@"UserID"];
            [[StorageMgr singletonStorageMgr] addKey:@"UserID" andValue:models[@"id"]];
            [[StorageMgr singletonStorageMgr] addKey:@"Nickname" andValue:models[@"nickname"]];
            NSLog(@"idididid = %@",models[@"id"]);
                           //记忆用户名
                [Utilities setUserDefaults:@"Username" content:username];
                //将文本框的内容清除
                _passwordTF.text = @"";
                [Utilities popUpAlertViewWithTrue:@"登录成功" andTitle:@"确定" onView:self tureAction:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
            
                }];
        } else{
            [Utilities popUpAlertViewWithMsg:@"用户名与密码不匹配" andTitle:nil onView:self];
        }
    
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error.description);
        [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍候再试" andTitle:nil onView:self];
        [avi stopAnimating];
        self.navigationController.view.self.userInteractionEnabled = YES;
    }];

}

//隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (IBAction)ReturnAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
