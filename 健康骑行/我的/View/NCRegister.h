//
//  NCRegister.h
//  健康骑行
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCRegister : UIViewController
/*请输入手机号**/
@property(nonatomic,strong)UITextField *txtPhone;
/*获取验证码**/
@property(nonatomic,strong)UITextField *txtSecurity;

@end
