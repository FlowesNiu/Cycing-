//
//  NCChangeConditions.m
//  健康骑行
//
//  Created by qingyun on 16/8/24.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCSexVC.h"


@interface NCSexVC ()

@property(nonatomic,strong)UIAlertController *alertCtr;
@property (strong, nonatomic) IBOutlet UIButton *man;
@property (strong, nonatomic) IBOutlet UILabel *lalMW;
@property (strong, nonatomic) IBOutlet UIButton *wman;
@end


@implementation NCSexVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"性别";
    [self loadDefaultSetting];
}
-(void)loadDefaultSetting{
    
}
- (IBAction)WAM:(id)sender {
    _lalMW.text = @"女";
}
- (IBAction)MAN:(id)sender {
    _lalMW.text = @"男";
}
- (IBAction)btnSex:(id)sender {
    if (self.sexblock) {
        self.sexblock(self.lalMW.text);
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.lalMW.text forKey:@"sexVC"];

    [self.navigationController popViewControllerAnimated:YES];
}
//- (IBAction)bntNext:(id)sender {
//
//    NSString *msg;
//    
//    if ([_lalWM.text isEqualToString:@""]) {
//        [self alertActionWithMessage:@"请选择你的性别"];
//    }else{
//        NCHeightVC *heightvc = [[NCHeightVC alloc]initWithNibName:@"NCHeightVC" bundle:[NSBundle mainBundle]];
//        [self.navigationController pushViewController:heightvc animated:YES];
//    }
//    
//  
// }
//
/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [self.alertCtr addAction:alertAction];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
}

@end
