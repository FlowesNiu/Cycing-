//
//  NCEquipment.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCEquipment.h"
#import <Masonry/Masonry.h>
#import "NCEquipmentOne.h"
#import "NCEquipmentTwo.h"
#import "NCEquipmentThere.h"
#import "NCEquipmentFour.h"
@interface NCEquipment ()
@property (weak, nonatomic) IBOutlet UIButton *equipment1;
@property (weak, nonatomic) IBOutlet UIButton *equipment2;
@property (weak, nonatomic) IBOutlet UIButton *equipment3;
@property (weak, nonatomic) IBOutlet UIButton *equipment4;
/*提示信息**/
@property(nonatomic,strong)UIAlertController *alertCtr;

@end

@implementation NCEquipment
- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"设备";
}
- (void)viewDidLoad {
    [super viewDidLoad];    
    [self loadDefuiSetting];
    //添加设备的按钮
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]init];
//    barItem.target = self;
//    barItem.action = @selector(customLocation);
//    barItem.title = @"+";
//    self.navigationItem.rightBarButtonItem = barItem;
   
}


-(void)loadDefuiSetting{

    [self.equipment1 addTarget:self action:@selector(equipmentOne) forControlEvents:UIControlEventTouchUpInside];
    [self.equipment2 addTarget:self action:@selector(equipmentTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.equipment3 addTarget:self action:@selector(equipmentThere) forControlEvents:UIControlEventTouchUpInside];
    [self.equipment4 addTarget:self action:@selector(equipmentFour) forControlEvents:UIControlEventTouchUpInside];
    

   }
-(void)equipmentOne
{
    NCEquipmentOne *one = [[NCEquipmentOne alloc]init];
    [self.navigationController pushViewController:one animated:YES];
 }
-(void)equipmentTwo{
    NCEquipmentTwo *two = [[NCEquipmentTwo alloc]init];
    [self.navigationController pushViewController:two animated:YES];

}
-(void)equipmentThere{
    NCEquipmentThere *there = [[NCEquipmentThere alloc]init];
    [self.navigationController pushViewController:there animated:YES];
}
-(void)equipmentFour{
    NCEquipmentFour *four = [[NCEquipmentFour alloc]init];
    [self.navigationController pushViewController:four animated:YES];

}
-(void)customLocation{

    [self alertActionWithMessage:@"敬请期待"];
}
/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [self.alertCtr addAction:alertAction];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
    
}
@end
