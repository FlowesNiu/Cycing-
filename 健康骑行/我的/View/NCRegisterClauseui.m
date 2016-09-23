//
//  NCRegisterClauseui.m
//  健康骑行
//
//  Created by qingyun on 16/8/20.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCRegisterClauseui.h"

@interface NCRegisterClauseui ()

@end

@implementation NCRegisterClauseui

- (void)viewDidLoad {
    [super viewDidLoad];
 self.title = @"服务条款";
    [self loadDefaultSetting];
  
}
-(void)loadDefaultSetting{
    //背景图片
    UIImageView *imageClauseui = [[UIImageView alloc]init];
    imageClauseui.image = [UIImage imageNamed:@"服务条款"];
    imageClauseui.frame = self.view.bounds;
    [self.view addSubview:imageClauseui];
    //beijing tupian shang de view
    UIView *viewClauseui = [[UIView alloc]init];
    viewClauseui.frame = self.view.bounds;
    viewClauseui.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:viewClauseui];
    //创建一个uilable
    UILabel * txtView = [[UILabel alloc]init];
//    self.navigationController.navigationBarHidden= YES;
    txtView.alpha = 0.5;
    txtView.textColor = [UIColor redColor];
    txtView.frame = self.view.bounds;
    txtView.numberOfLines = 0;
    txtView.font = [UIFont systemFontOfSize:22];
    txtView.text = @"用户协议请在使用本平台前仔细阅读这些使用条款。在台式机，笔记本，移动终端或者其他设备（以下统称“设备”）上使用本网站、手机应用或其他健康骑行产品或服务(“本平台”)即表明您已经阅读、理解并同意受本使用条款和其他适用法律约束，不论您是否为健康骑行的注册用户。健康骑行有权在任何时间不经通知地修改这些使用条款，并于公布在平台之时起生效。您对本平台的继续使用应被理解为您对经修订的本使用条款的接受。身体活动本平台可能包括一些推广身体活动的功能。请在参与任何该等身体活动前考虑其中包含的风险并咨询医疗专业人士。健康骑行对您使用或不能使用本平台的功能所可能蒙受的任何伤害或损害不承担任何责任。";
    [viewClauseui addSubview:txtView];
    
}


@end
