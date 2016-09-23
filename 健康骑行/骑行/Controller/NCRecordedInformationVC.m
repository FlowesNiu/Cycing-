//
//  NCRecordedInformationVC.m
//  健康骑行
//
//  Created by qingyun on 16/8/29.
//  Copyright © 2016年 牛广道. All rights reserved.
//记录界面


#import "NCRecordedInformationVC.h"
#import "NCCycling.h"
#import "AppDelegate.h"
#import "NCCyclingData.h"
#import <AVOSCloud/AVOSCloud.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <CoreLocation/CoreLocation.h>
#import <Masonry/Masonry.h>

@interface NCRecordedInformationVC ()<BMKMapViewDelegate>
@property(nonatomic,strong)UIView *isMapView;
/*初始化地图**/
@property(nonatomic,strong)BMKMapView *_mapView;
/**总里程*/
@property (weak, nonatomic) IBOutlet UILabel *lalMileage;
/**骑行总时间*/
@property (strong, nonatomic) IBOutlet UILabel *lalCyclingTime;


/**平均速度*/
@property (strong, nonatomic) IBOutlet UILabel *lalAverageSpeed;

/**休息时间*/
@property (strong, nonatomic) IBOutlet UILabel *lalRestTime;
/**开始的按钮*/
@property (strong, nonatomic) IBOutlet UIButton *btnAction;

/**暂停的按钮*/
@property (strong, nonatomic) IBOutlet UIButton *btnPause;

/**结束的按钮*/
@property (strong, nonatomic) IBOutlet UIButton *btnEndOver;

@property(nonatomic,strong)AppDelegate *app;
/*提示信息**/
@property(nonatomic,strong)UIAlertController *alertCtr;

/**时间*/
@property(nonatomic,strong)NSTimer *restTime;
/**小时*/
@property(nonatomic,assign)NSInteger restHours;
/**分钟*/
@property(nonatomic,assign)NSInteger restMinutes;
/**秒*/
@property(nonatomic,assign)NSInteger restSeconds;
/**毫秒*/
@property(nonatomic,assign)NSInteger restPersent;

@property(nonatomic,strong) NSString *strTime;
@end

@implementation NCRecordedInformationVC
-(void)viewWillAppear:(BOOL)animated{
    [__mapView viewWillAppear];
    __mapView.delegate = self;
    if (!(_app.time == 0)) {
        self.btnAction.alpha = 0;
        self.btnPause.alpha =1;
        self.btnEndOver.alpha = 1;
        
    }else{
        self.btnAction.alpha = 1;

    }
    

}
-(void)viewWillDisappear:(BOOL)animated{

    [__mapView viewWillDisappear];
    __mapView.delegate =nil;


}
- (void)viewDidLoad {
    [super viewDidLoad];;
//    [self loadDefaultSetting];
//    _btnPause.alpha = 0;
//    _btnEndOver.alpha =0;
     _app= [[UIApplication sharedApplication]delegate];
    __weak NCRecordedInformationVC *vc = self;
    [_app setCurrentValue:^(NSString *timeStr) {
        vc.lalCyclingTime.text = timeStr;
    }];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = @"记录";
    }

//点击开始
- (IBAction)btnAction:(id)sender {
    self.btnPause.alpha =1;
    self.btnAction.alpha = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strDef = [defaults objectForKey:@"txtUserName"];
    if (strDef){
        [_app NCRecordedInformationVC];
    }else{
    
        [self alertActionWithMessage:@"您还没有登陆,请先点击个人进行登陆"];
    
    }
 
    [self.restTime setFireDate:[NSDate distantFuture]];
    
}
//点击暂停
- (IBAction)btnbtnPause:(id)sender {
//    self.btnAction.alpha = 1;
//    self.btnPause.alpha = 0;
    [self dianjizanting];
    }
//点击结束
- (IBAction)btnEndOver:(id)sender {
    [self alertActionWithMessageConserve:@"是否保存此次行程"];
}
//从这个界面跳转到map界面

- (IBAction)btnSkipMap:(id)sender {
//    NCCycling *cyc = [[NCCycling alloc]init];
    if (self.NCCycingBlock) {
        self.NCCycingBlock(self.lalCyclingTime.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/** 提示信息*/
-(void)alertActionWithMessage:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
      UIAlertAction *alertAction1= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [self.alertCtr addAction:alertAction];
    [self.alertCtr addAction:alertAction1];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
    
}

//保存数据的提示信息
-(void)alertActionWithMessageConserve:(NSString *)message {
    self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //保存调用的方法
        [self SaveTheCyclingData];
    }];
    UIAlertAction *alertAction1= [UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self conserveNo];
    }];
    [self.alertCtr addAction:alertAction];
    [self.alertCtr addAction:alertAction1];
    [self presentViewController:self.alertCtr animated:YES completion:nil];
    
}

//点击保存调用的发那个方法
-(void)SaveTheCyclingData{
    

//    NSLog(@"%@",self.lalCyclingTime);
       self.lalMileage.text = [NSString stringWithFormat:@"%@",self.zongLicheng];
    NSInteger integer = [self.zongLicheng intValue];
    CGFloat miao = (_app._hours*60)+(_app._minutes)+(_app._seconds / 60);
    NSInteger pingjun = integer / miao;
    if (pingjun < 1) {
        pingjun = 0;
    }
    self.lalAverageSpeed.text = [NSString stringWithFormat:@"%ld",pingjun];
    NSDictionary *dict = @{@"lalCyclingTime":self.lalCyclingTime.text,@"lalRestTime":self.lalRestTime.text,@"lalMileage":self.lalMileage.text,@"lalAverageSpeed":self.lalAverageSpeed.text};
        AVObject *user = [AVObject objectWithClassName:@"userInfoMation"];
    [user setObject:[AVUser currentUser].username forKey:@"userName"];
    [user setObject:dict forKey:@"mation"];
    //保存到云端
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

        NSLog(@"error%@",error);
    }];
    [self Timer];
}

//点击不保存调用的方法
-(void)conserveNo{
    [self Timer];
}

//点击暂停的时候，调用这个方法
-(void)dianjizanting{
    self.btnPause.alpha = 0;
    self.btnAction.alpha =1;
    [_app.time setFireDate:[NSDate distantFuture]];
    [self.restTime setFireDate:[NSDate date]];
//    if (self.btnPause.selected
//        != YES) {
//        self.btnPause.selected = YES;
//        //点击暂停，总时间暂停
//        [_app.time setFireDate:[NSDate distantFuture]];
//        //        [_app stopTimer];
//        //点击暂停之后 休息时间开始启动
    if (_restTime == 0) {
        [self.restTime setFireDate:[NSDate date]];
            _restTime = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(restRunch) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:_restTime forMode:NSRunLoopCommonModes];
    
}
//        }else{
//            NSLog(@"时间没有启动");
//            [self.restTime setFireDate:[NSDate date]];
//        }
//        
//    }else if (self.btnPause.selected == YES){
//        
//        [self.restTime setFireDate:[NSDate distantFuture]];
//        // 点击继续 总时间q启动
//        [_app.time setFireDate:[NSDate date]];
//    }
}
//休息时间timer 调用
-(void)restRunch{
    _restPersent ++;
    if (_restPersent == 100) {
        _restSeconds ++;
        _restPersent = 0;
    }
    if (_restSeconds == 60) {
        _restMinutes ++;
        _restSeconds = 0;
    }
    if (_restMinutes == 60) {
        _restHours ++;
        _restMinutes = 0;
    }
    
    _strTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_restHours,_restMinutes,_restSeconds];
    self.lalRestTime.text = _strTime;
}

-(void)Timer{
    self.btnAction.alpha = 1;
    self.btnPause.alpha = 1;
    [_app.time invalidate];
    _app._hours = 0 ;
    _app._minutes = 0;
    _app._seconds = 0;
    _app._persent = 0;
    self.lalCyclingTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_app._hours,_app._minutes,_app._seconds]
    ;
    _app.time = 0;
    [self.restTime invalidate];
    
    NCCycling *CYC = [[NCCycling alloc]init];
    
    CYC.lalDuration.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_app._hours,_app._minutes,_app._seconds];
    self.restHours = 0;
    self.restMinutes = 0;
    self.restPersent = 0;
    self.restSeconds = 0;

    self.lalRestTime.text =[NSString stringWithFormat:@"%02ld:%02ld:%02ld",self.restHours,self.restMinutes,self.restSeconds];
    self.restTime = 0;
    self.lalAverageSpeed.text = @"00";

}
@end
