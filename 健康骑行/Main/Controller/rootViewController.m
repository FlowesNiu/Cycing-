//
//  ViewController.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "rootViewController.h"
#import "NCCycling.h"/*骑行**/
#import "NCTool.h"/*工具**/
#import "NCEquipment.h"/*设备**/
#import "NCPersonager.h"/*个人**/
#import "NCAccountUserName.h"
#import "NCAccountUserName.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}
-(void)loadDefaultSetting{
    /*骑行**/
    NCCycling *cyclingVC =[[NCCycling alloc]initWithNibName:@"NCCycling" bundle:[NSBundle mainBundle]];
        [self setViewController:cyclingVC imageName:@"riding_normal" title:@"骑行"];
    /*工具**/
    NCTool *toolVC = [[NCTool alloc]init];
    [self setViewController:toolVC imageName:@"tool_normal" title:@"数据"];
    /*设备**/
    NCEquipment *equipmentVC = [[NCEquipment alloc]initWithNibName:@"NCEquipment" bundle:[NSBundle mainBundle]];
    [self setViewController:equipmentVC imageName:@"device_normal" title:@"设备"];
    /*个人**/
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strDef = [defaults objectForKey:@"txtUserName"];
    if (strDef) {
        UIStoryboard *stroyboard =[UIStoryboard storyboardWithName:@"NCAccountUserName" bundle:nil];
        NCAccountUserName *account = [stroyboard instantiateViewControllerWithIdentifier:@"account"];
        __weak rootViewController *VC = self;
        [account setLogOutBlock:^{
            [VC loadDefaultSetting];
        }];
        [self setViewController:account imageName:@"personage_normal" title:@"个人"];
    }else{
        NCPersonager *personagerVC =[[NCPersonager alloc]init];
        [self setViewController:personagerVC imageName:@"personage_normal" title:@"个人"];
    }
}
//封装一个方法，上面调用
-(void)setViewController:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title{
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.title = title;
    UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:vcNav];
}
@end
