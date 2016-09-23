//
//  NCRegister.m
//  健康骑行
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 牛广道. All rights reserved.
//注册界面

#import "NCRegister.h"
#import "NCRegisterClauseui.h"
#import <Masonry/Masonry.h>
#import "NCChangeConditions.h"
#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import <SMS_SDK/SMSSDK.h>
#import "NCAccountUserName.h"
@interface NCRegister (){
    NSInteger _count;

}
/*请输入用户名**/
@property(nonatomic ,strong)UITextField *txtUserName;

/*区域号**/
@property(nonatomic,strong)NSString *zone;
/*请输入验证码的按钮**/
@property(nonatomic,strong)UIButton *btnSecurity;
/*请输入密码**/
@property(nonatomic ,strong)UITextField *txtPwd;
/*请确认密码**/
@property(nonatomic ,strong)UITextField *txtConfirmPwd;
/*提示信息**/
@property(nonatomic,strong)UIAlertController *alertCtr;
@end

@implementation NCRegister

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.title = @"注册";
}

-(void)loadDefaultSetting{
    
    //创建一个北京图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"注册"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
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
    
    //创建一个label显示用户名
    UILabel *lalUserName = [[UILabel alloc]init];
    lalUserName.text = @"用  户  名:";
    [LoginVc addSubview:lalUserName];
    [lalUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(40));
        make.leading.equalTo(@(20));
        make.width.equalTo(@(75));
        //  make.height.equalTo(@(200));
    }];

    //创建一个textfile上面显示输入的用户名
    _txtUserName = [[UITextField alloc]init];
    _txtUserName.placeholder = @"请输入用户名";
    _txtUserName.backgroundColor = [UIColor clearColor];
    _txtUserName.textAlignment = NSTextAlignmentLeft;
    _txtUserName.clearButtonMode =UITextFieldViewModeAlways;
    [LoginVc addSubview:_txtUserName];
    [_txtUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lalUserName.mas_trailing).offset(10);
        make.centerY.equalTo(lalUserName);
        make.height.equalTo(lalUserName);
        make.width.equalTo(@(150));
    }];
    
    // 创建一个lable 显示手机号
    UILabel *lalPhone = [[UILabel alloc]init];
    lalPhone.text = @"手  机  号:";
    [LoginVc addSubview:lalPhone];
    [lalPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lalUserName.mas_bottom).offset(20);
        make.leading.equalTo(lalUserName.mas_leading);
        make.width.equalTo(lalUserName);
        }];
    
     //创建一个txt 显示手机号
    _txtPhone = [[UITextField alloc]init];
    _txtPhone.placeholder = @"请输入手机号";
    _txtPhone.backgroundColor =[ UIColor clearColor];
    _txtPhone.textAlignment = NSTextAlignmentLeft;
    _txtPhone.clearButtonMode = UITextFieldViewModeAlways;
    [LoginVc addSubview:_txtPhone];
    [_txtPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lalPhone.mas_trailing).offset(10);
        make.centerY.equalTo(lalPhone);
        make.width.equalTo(_txtUserName);
    }];

    //创建一个一个textf 获取验证码
    _txtSecurity = [[UITextField alloc]init];
    _txtSecurity.placeholder = @"请输入验证码";
    _txtSecurity.backgroundColor =[ UIColor clearColor];
    _txtSecurity.textAlignment = NSTextAlignmentLeft;
    _txtSecurity.clearButtonMode = UITextFieldViewModeAlways;
    [LoginVc addSubview:_txtSecurity];
    [_txtSecurity mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(lalPhone.mas_bottom).offset(20);
        make.leading.equalTo(lalPhone.mas_leading);
        make.width.equalTo(_txtPhone);
    
    }];

    //创建一个lable 显示密码
    UILabel *lalPwd = [[UILabel alloc]init];
    lalPwd.text = @"密       码 :";
    [LoginVc addSubview:lalPwd];
    [lalPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtSecurity.mas_bottom).offset(20);
        make.leading.equalTo(lalPhone .mas_leading);
        make.centerX.equalTo(lalUserName);
        make.width.equalTo(lalUserName);
    }];
    
//    创建一个txt 显示密码
    _txtPwd = [[UITextField alloc]init];
    _txtPwd.placeholder = @"请输入密码";
    _txtPwd.backgroundColor =[ UIColor clearColor];
    _txtPwd.textAlignment = NSTextAlignmentLeft;
    _txtPwd.secureTextEntry = YES;
    _txtPwd.clearButtonMode = UITextFieldViewModeAlways;
    self.txtPwd = _txtPwd;
    [LoginVc addSubview:_txtPwd];
    [_txtPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lalPwd.mas_trailing).offset(10);
        make.centerY.equalTo(lalPwd);
        make.width.equalTo(_txtUserName);
    }];
    
    //创建一个lable 显示确认密码
    UILabel *lalConfirmPwd = [[UILabel alloc]init];
    lalConfirmPwd.text = @"确认密码:";
    [LoginVc addSubview:lalConfirmPwd];
    [lalConfirmPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lalPwd.mas_bottom).offset(20);
        make.leading.equalTo(lalPwd.mas_leading);
        make.width.equalTo(lalPwd);
    }];
    
    //创建一个txt 显示确认密码
    _txtConfirmPwd = [[UITextField alloc]init];
    _txtConfirmPwd.placeholder = @"请确认密码";
    _txtConfirmPwd.backgroundColor =[ UIColor clearColor];
    _txtConfirmPwd.textAlignment = NSTextAlignmentLeft;
    _txtConfirmPwd.secureTextEntry = YES;
    _txtConfirmPwd.clearButtonMode = UITextFieldViewModeAlways;
    self.txtConfirmPwd = _txtConfirmPwd;
    [LoginVc addSubview:_txtConfirmPwd];
    [_txtConfirmPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lalConfirmPwd.mas_trailing).offset(10);
        make.centerY.equalTo(lalConfirmPwd);
        make.width.equalTo(_txtPwd);
    }];
    
    //创建一个button 显示的是获取验证码
    _btnSecurity = [[UIButton alloc]init];
    [_btnSecurity setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_btnSecurity setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [_btnSecurity setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
     [_btnSecurity setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    _btnSecurity.layer.masksToBounds = YES;
    _btnSecurity.layer.cornerRadius = 10.0;
    [_btnSecurity addTarget:self action:@selector(Security) forControlEvents:UIControlEventTouchUpInside];
    [LoginVc addSubview:_btnSecurity];
    [_btnSecurity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_txtSecurity);
        make.leading.equalTo(_txtSecurity.mas_trailing).offset(-10);
        make.trailing.equalTo(_txtPhone);
    }];
 
    //创建一个BUTTON 登录
    UIButton *btnLogin = [[UIButton alloc]init];;
    [btnLogin setTitle:@"注册" forState:UIControlStateNormal];
    [btnLogin setTitle:@"注册" forState:UIControlStateHighlighted];
    btnLogin.backgroundColor = [UIColor orangeColor];
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 10.0;
    [btnLogin addTarget:self action:@selector(registerLogin) forControlEvents:UIControlEventTouchUpInside];
    [LoginVc addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtConfirmPwd.mas_bottom).offset(30);
        make.leading.equalTo(LoginVc).offset(30);
        make.trailing.equalTo(LoginVc).offset(-30);
        make.height.mas_equalTo(40);
    }];

//创建一个label 上面现实的时条款
    UILabel *lalClauseui = [[UILabel alloc]init];
    lalClauseui.text = @"使用健康骑行代表同意";
    lalClauseui.font = [UIFont systemFontOfSize:14];
    [LoginVc addSubview:lalClauseui];
    [lalClauseui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnLogin.mas_bottom).offset(120);
        make.leading.equalTo(btnLogin);
        
    }];
    //创建一个button 上面现实的服务条款
    UIButton *btnClauseui = [[UIButton alloc]init];
    [btnClauseui setTitle:@"服务条款" forState:UIControlStateNormal];
    [btnClauseui setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnClauseui setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    [btnClauseui addTarget:self action:@selector(clauseui) forControlEvents:UIControlEventTouchUpInside];
    btnClauseui.titleLabel.font = [UIFont systemFontOfSize:14];
    [LoginVc addSubview:btnClauseui];
    [btnClauseui mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lalClauseui);
        make.leading.equalTo(lalClauseui.mas_trailing).offset(8);
        
    }];
}


#pragma mark ----Button Action
//点击注册，触发的事件
-(void)registerLogin{
    
    /*验证用户名**/
    if ([_txtUserName.text isEqualToString:@""]) {
        [self alertActionWithMessage:@"用户名不能为空"];
    }else if ((_txtUserName.text.length <3)|| (_txtUserName.text.length >20)){
        [self alertActionWithMessage:@"用户名的长度大于3&小于20"];
    }
    /*验证手机号**/
    if ([_txtPhone.text isEqualToString:@""]) {
        [self alertActionWithMessage:@"手机号不能为空"];
    }else{
    NSString *str = @"^[1][3587][0-9]{9}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str];
        if ([pred evaluateWithObject:_txtPhone.text] == YES) {
        }else{
            [self alertActionWithMessage:@"手机号格式不对,请重新输入"];
        }
    }
    /*判断验证码不能为空**/
    if ([_txtSecurity.text isEqualToString:@""]) {
        [self alertActionWithMessage:@"验证码不能为空"];
    }else{
    /**********************************/
    }
    /*判断密码**/
    if ([_txtPwd.text isEqualToString:@""]) {
        [self alertActionWithMessage:@"密码不能为空"];
    }else if ((_txtPwd.text.length >7)||(_txtPwd.text.length < 17)){
        if ([_txtPwd.text isEqualToString:_txtConfirmPwd.text]){
//            NSLog(@"密码一致");
        }else{
            [self alertActionWithMessage:@"密码不一致,请重新输入"];
        }    
    }else{
    [self alertActionWithMessage:@"密码的位数大于7&小于17"];
    }
    //创建提交验证码的按钮，或者是在自己已经有的界面的按钮事件里调用提交验证码的方法
    AVUser *user = [[AVUser alloc]init];
    [SMSSDK commitVerificationCode:self.txtSecurity.text phoneNumber:_txtPhone.text zone:@"86" result:^(NSError *error) {
        if (error) {
        [self alertActionWithMessage:@"验证码错误"];
        }
    }];
    
    /**判断所有信息是不是为空，不是空的话才可以注册*/
    /**z注册账号*/
    
    user.username = self.txtUserName.text;
    user.password = self.txtPwd.text;
    user.mobilePhoneNumber = self.txtPhone.text;
    //保存用异步模式18638691087
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIStoryboard *stroyboard =[UIStoryboard storyboardWithName:@"NCAccountUserName" bundle:nil];
            NCAccountUserName *account = [stroyboard instantiateViewControllerWithIdentifier:@"account"];
            [self.navigationController pushViewController:account animated:YES];
//            NSLog(@"注册成功");
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:user.username forKey:@"txtUserName"];
            [def setObject:user.mobilePhoneNumber forKey:@"phoneNumber"];
            [def setObject:user.password forKey:@"UserPWD"];
            [def synchronize];
            //        AppDelegate *app = [[UIApplication sharedApplication]delegate];
        }else{
            if (error.code == 202) {
                [self alertActionWithMessage:@"该用户名已经存在"];
            }else if (error.code == 214){
                [self alertActionWithMessage:@"手机号码已经存在"];
            }else{
//                NSLog(@"全程无毛病");
            
            }
        }
   }];
    /*---------------------------------------------------------*/
    /*注册成功后。跳转到登陆界面，3秒自动跳转，或者点击立即跳转*/
   
}

/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [self.alertCtr addAction:alertAction];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
}

//获取验证码
-(void)Security{
    if (![self.txtPhone.text isEqualToString:@""]||(self.txtPhone.text==NULL)) {
        NSString *str = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str];
        if ([pred evaluateWithObject:_txtPhone.text] == YES) {
            /**
             *  @from                    v1.1.1
             *  @brief                   获取验证码(Get verification code)
             *
             *  @param method            获取验证码的方法(The method of getting verificationCode)
             *  @param phoneNumber       电话号码(The phone number)
             *  @param zone              区域号，不要加"+"号(Area code)
             *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
             *  @param result            请求结果回调(Results of the request)
             */
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_txtPhone.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
                if (!error) {
//                    NSLog(@"手机收到短信说明：获取成功");
                }else{
//                    NSLog(@"错误信息%@",error);
                
                }
            }];
            [self performSelector:@selector(countClick) withObject:nil];
        }else{
            [self alertActionWithMessage:@"手机号格式不对,请重新输入"];
        }

    }else{
        [self alertActionWithMessage:@"手机号不能为空"];
    }
}

-(void)countClick{
    _btnSecurity.enabled = NO;
    _count = 60;
    [_btnSecurity  setTitle:@"60" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFired:) userInfo:nil repeats:YES];
}

-(void)timeFired:(NSTimer *)timer{
    if (_count !=1) {
        _count -= 1;
        [_btnSecurity setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
    }else{
    
        [timer invalidate];
        _btnSecurity.enabled = YES;
        [_btnSecurity setTitle:@"获取验证码" forState:UIControlStateNormal]
        ;
    }
}

//点击条款，触发的事件
-(void)clauseui{
    NCRegisterClauseui *regcla = [[NCRegisterClauseui alloc]init];
    [self.navigationController pushViewController:regcla animated:YES];
}
@end
