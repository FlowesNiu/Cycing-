//
//  NCPersonager.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCPersonager.h"
#import <Masonry/Masonry.h>
#import "NCLogin.h"

@interface NCPersonager ()
@end

@implementation NCPersonager
- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBarHidden = YES;
//     avigationBarHidden:YES]
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    [self loadDefaultSetting];
}
-(void)loadDefaultSetting{
    //创建一个uiimage
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = self.view.bounds;
    image.image =[UIImage imageNamed:@"Login-1"];
    [self.view addSubview:image];
    
    //创建一个button
    UIButton *btnLogin = [[UIButton alloc]init];
    [btnLogin setTitle:@"点击登录" forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:40];
    [btnLogin setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
      [btnLogin addTarget:self action:@selector(modelViewGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(50));
        make.width.equalTo(@(200));
    }];
}

//button触发的响应事件
-(void)modelViewGo{
    NCLogin *loginaction = [[NCLogin alloc]init];
    [self.navigationController pushViewController:loginaction animated:YES];
}

@end
