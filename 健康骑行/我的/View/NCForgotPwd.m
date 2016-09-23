//
//  NCForgotPwd.m
//  健康骑行
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 牛广道. All rights reserved.
//忘记密码

#import "NCForgotPwd.h"
#import "NCRegister.h"
#import <SMS_SDK/SMSSDK.h>
#import <AVOSCloud/AVOSCloud.h>
#import <SMS_SDK/SMSSDK.h>

@interface NCForgotPwd (){


  NSInteger _count;
}
/*注册时的手机号**/
@property (strong, nonatomic) IBOutlet UITextField *txtForgotPhone;
/*验证码**/
@property (strong, nonatomic) IBOutlet UITextField *txtForgotSecurity;
/*新的密码**/
@property (strong, nonatomic) IBOutlet UITextField *txtForgotPWD;
/*点击保存的btn**/
@property (strong, nonatomic) IBOutlet UIButton *btnForgotbtn;
/*点击获取验证码的btn**/
@property (strong, nonatomic) IBOutlet UIButton *btnForgotGainSecurity;


@property(nonatomic,strong)UIAlertController *alertCtr;
@end

@implementation NCForgotPwd

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
 self.title = @"忘记密码";
    
}
-(void)loadDefaultSetting{
    _btnForgotbtn.layer.cornerRadius = 17;
    _btnForgotbtn.layer.masksToBounds = YES;
     //判断手机号是不是在服务器已经注册过
//    AVUser *user = [[AVUser alloc]init];
    
    
}
//点击获取验证码触发的事件
- (IBAction)btnVerificationCode:(id)sender {
    
    if ([self.txtForgotPhone.text isEqualToString:@""]||(self.txtForgotPhone.text==NULL)) {
        [self alertActionWithMessage:@"请输入手机号"];
    }else{
    
//        NSLog(@"有手机号");
    
    }
//    [[NSUserDefaults standardUserDefaults]objectForKey:@"phoneNumber"]
//    如果输入的手机号和服务器存在的手机号不匹配user.mobilePhoneNumber
//  AVUser *user = [AVUser currentUser];
//    if ([self.txtForgotPhone.text isEqualToString:user.mobilePhoneNumber]) {
//        [self countClick];
//    }else{
//        [self alertActionWithMessage:@"手机号码和注册号码不一致,请确认输入"];
//    
//    }
    [AVUser requestPasswordResetWithPhoneNumber:self.txtForgotPhone.text  block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
//         NSLog(@"验证成功");
          }else{
//         NSLog(@"验证失败%@",error);
         }
    }];

}


-(void)countClick{
    
_btnForgotGainSecurity.enabled = NO;
    _count = 60;
    [_btnForgotGainSecurity  setTitle:@"60" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFired:) userInfo:nil repeats:YES];
}
     

-(void)timeFired:(NSTimer *)timer{
    if (_count !=1) {
        _count -= 1;
        [_btnForgotGainSecurity setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
    }else{
        
        [timer invalidate];
        _btnForgotGainSecurity.enabled = YES;
        [_btnForgotGainSecurity setTitle:@"获取验证码" forState:UIControlStateNormal]
        ;
    }
}



//点击保存让新密码保存
- (IBAction)btnForgotPWD:(id)sender {
    
    
    [AVUser resetPasswordWithSmsCode:self.txtForgotSecurity.text newPassword:@"password" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
//            NSLog(@"0987654321");

        } else {
//            NSLog(@"%@",error);
            
        }
    }];
    
    
    
    
}
/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [self.alertCtr addAction:alertAction];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
}


@end
