//
//  NCLogin.m
//  健康骑行
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCLogin.h"
#import <Masonry/Masonry.h>
#import "NCRegister.h"
#import "NCAccountUserName.h"
#import <AVOSCloud/AVOSCloud.h>
/*登录**/
#import "NCLoginVC.h"
/*立即注册**/
#import "NCRegister.h"
/*忘记密码**/
#import "NCForgotPwd.h"
/*第三方qq登录**/
#import "NCLoginQQ.h"
/*第三方微信登录**/
#import "NCLoginWX.h"
@interface NCLogin ()
/*用户名**/
@property(nonatomic,strong)UITextField *txtUserName;
/*密码**/
@property(nonatomic,strong)UITextField *txtPwd;
/*密码**/
@property(nonatomic,strong)UIAlertController *alertCtr;



@end

@implementation NCLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.navigationItem setHidesBackButton:YES];
    
    [self loadDefaultSetting];
}

-(void)loadDefaultSetting{
    //创建一个背景图片
    UIImageView *imageVC = [[UIImageView alloc]init];
//    imageVC.frame = self.view.bounds;
    imageVC.image = [UIImage imageNamed:@"登录1"];
    [self.view addSubview:imageVC];
    [imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(self.view);
    }];
    //创建一个view 在背景图片上
    UIView *LoginVc = [[UIView alloc]init];
    LoginVc.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:LoginVc];
    [LoginVc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.leading.equalTo(self.view).offset(40);
        make.trailing.equalTo(self.view).offset(-40);
        make.bottom.equalTo(self.view).offset(-80);
        
    }];
    //创建一个label 上面显示昵称
    UILabel *laluserName = [[UILabel alloc]init];
    laluserName.text = @"用户名:";
    laluserName.backgroundColor = [UIColor clearColor];
    laluserName.frame = CGRectMake(40, 30, 60, 30);
    [LoginVc addSubview:laluserName];
    [LoginVc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LoginVc).offset(20);
        make.leading.equalTo(LoginVc).offset(20);
        

    }];

    //创建一个textfile上面显示输入的用户名
    _txtUserName = [[UITextField alloc]init];
    _txtUserName.placeholder = @"请输入用户名";
    _txtUserName.backgroundColor = [UIColor clearColor];
    _txtUserName.textAlignment = NSTextAlignmentLeft;
    _txtUserName.clearButtonMode =UITextFieldViewModeAlways;
    [LoginVc addSubview:_txtUserName];
    [_txtUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(laluserName.mas_trailing).offset(10);
        make.centerY.equalTo(laluserName);
        make.height.equalTo(laluserName);
    }];
    //创建一个label 上面显示密码
    UILabel *lalPassword = [[UILabel alloc]init];
    lalPassword.text = @"密码:";
    lalPassword.backgroundColor = [UIColor clearColor];
    //    lalPassword.frame = CGRectMake(40, 30, 60, 40);
    [LoginVc addSubview:lalPassword];
        [lalPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(laluserName.mas_bottom).offset(20);
            make.centerX.equalTo(laluserName);
            make.width.equalTo(laluserName);
            make.height.equalTo(laluserName);
        }];
    
    //创建一个textfile上面显示输入的密码
    _txtPwd = [[UITextField alloc]init];
    _txtPwd.placeholder = @"请输入密码";
    _txtPwd.backgroundColor = [UIColor clearColor];
    _txtPwd.textAlignment = NSTextAlignmentLeft;
    _txtPwd.secureTextEntry = YES;
    _txtPwd.clearButtonMode =UITextFieldViewModeAlways;
    [LoginVc addSubview:_txtPwd];
    
    [_txtPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lalPassword.mas_trailing).offset(10);
        make.centerY.equalTo(lalPassword);
        make.height.equalTo(lalPassword);
        make.width.equalTo(_txtUserName);
        
    }];
    
    //创建一个BUTTON 登录
    UIButton *btnLogin = [[UIButton alloc]init];;
    [btnLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [btnLogin setTitle:@"登陆" forState:UIControlStateHighlighted];
    btnLogin.backgroundColor = [UIColor orangeColor];
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 10.0;
    [btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [LoginVc addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtPwd.mas_bottom).offset(20);
        make.leading.equalTo(LoginVc).offset(20);
        make.trailing.equalTo(LoginVc).offset(-20);
        make.height.mas_equalTo(60);
    }];
    //创建一个button  显示立即注册
    UIButton *btnRegisterbtn = [[UIButton alloc]init];
    [btnRegisterbtn setTitle:@"立即注册 >" forState:UIControlStateNormal];
    [btnRegisterbtn setTitle:@"立即注册 >" forState:UIControlStateHighlighted];
    [btnRegisterbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btnRegisterbtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnRegisterbtn addTarget:self action:@selector(btnregister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegisterbtn];
    [btnRegisterbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnLogin.mas_bottom).offset(10);
        make.leading.equalTo(btnLogin);
        make.height.equalTo(@(44));
    }];
    //创建一个button  显示“忘记密码？”
    UIButton *btnForgotPassword = [[UIButton alloc]init];
    [btnForgotPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [btnForgotPassword setTitle:@"忘记密码？" forState:UIControlStateHighlighted ];
    [btnForgotPassword setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btnForgotPassword setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnForgotPassword addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [LoginVc addSubview:btnForgotPassword];
    [btnForgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnRegisterbtn);
        make.trailing.equalTo(LoginVc).offset(-10);
        make.width.equalTo(btnRegisterbtn);
    }];
//    //创建一个label 分界线boundary
//    UILabel *lalBoundary = [[UILabel alloc]init];
//    lalBoundary.text = @" -----------第三方账号登陆-----------";
//    lalBoundary.textColor = [UIColor greenColor];
//    [LoginVc addSubview:lalBoundary];
//    [lalBoundary mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(btnRegisterbtn.mas_bottom).offset(20);
//        make.leading.trailing.equalTo(LoginVc);
//    }];
    
    //创建一个button 作为第三方登陆的button
//    UIButton *btnQQ = [[UIButton alloc]init];
//    [btnQQ setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
//    [btnQQ addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
//    [LoginVc addSubview: btnQQ];
//    [btnQQ mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lalBoundary.mas_bottom).offset(40);
//        make.leading.equalTo(LoginVc).offset(80);
//        make.height.width.equalTo(@(50));
//    }];
//    
//    //创建一个button 作为第三方登陆的button
//    UIButton *btnWX = [[UIButton alloc]init];
//    [btnWX setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
//    [btnWX addTarget:self action:@selector(loginWx) forControlEvents:UIControlEventTouchUpInside];
//    [LoginVc addSubview:btnWX];
//    [btnWX mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(btnQQ);
//        make.trailing.equalTo(LoginVc).offset(-80);
//        make.width.height.equalTo(btnQQ);
//    }];
}

//点击登录时 触发得方法
-(void)login{

    //验证用户名的状态
    if ([_txtUserName.text isEqualToString:@""]) {
        [self alertActionWithMessage:@"用户名不能为空"];
    }else{
    }
    //验证密码的状态
    if ([_txtPwd.text isEqualToString:@""]) {
        [self alertActionWithMessage:@"密码不能为空"];
    }
    //登陆请求
    //用户名d登陆
    [AVUser logInWithUsernameInBackground:_txtUserName.text password:_txtPwd.text block:^(AVUser *user, NSError *error) {
        if (user) {
//
//            NSLog(@"登陆成功");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:user.username forKey:@"txtUserName"];
            [defaults synchronize];
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"NCAccountUserName" bundle:nil];
            NCAccountUserName *account= [story instantiateViewControllerWithIdentifier:@"account"];
            [self.navigationController pushViewController:account animated:YES];
        }else{
//            NSLog(@"%@", error);
            if (error.code == 210 ) {
            [self alertActionWithMessage:@"用户名或者密码错误"];
            }else if (error.code == 211){
            [self alertActionWithMessage:@"找不到该用户"];
            }
        }
    }];
    
    
}

//点击立即注册时 触发得方法
-(void)btnregister{
    NCRegister *registerVC = [[NCRegister alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//点击忘记密码 触发的方法
-(void)forgotPassword{

    NCForgotPwd *forgotPwd = [[NCForgotPwd alloc]initWithNibName:@"NCForgotPwd" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:forgotPwd animated:YES];
 }

////点击QQ 触发的方法
//-(void)loginQQ{
//     [self alertActionWithMessage:@"敬请期待"];
////    NCLoginQQ *loginQQ = [[NCLoginQQ alloc]init];
////    [self.navigationController pushViewController:loginQQ animated:YES];
//}
//
////点击WX 触发的方法
//-(void)loginWx{
//    [self alertActionWithMessage:@"敬请期待"];
////    NCLoginWX *loginWX = [[NCLoginWX alloc]init];
////    [self.navigationController pushViewController:loginWX animated:YES];
//}
/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [self.alertCtr addAction:alertAction];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
}

@end
