//
//  AppDelegate.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Guidevc.h"
#import <SMS_SDK/SMSSDK.h>
#import "NCRecordedInformationVC.h"


@interface AppDelegate ()


@end

/*AppID**/
//JX4vfLNIeHNcOQrwBa3tsXyc-gzGzoHsz
/*App Key**/
//N2ssad2DcmwL6iOGbAK8XUmm
/*Master Key**/
//qtYtCGOtq5CI12BXlI06DAkx
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /**--------------------------------------------*/
    //初始化应用，appkey 和appSecret从后台申请的
    [SMSSDK registerApp:@"168b23a858a4e" withSecret:@"b3a70854229f87c05b2ce939bb441603"];
    //AVOSCloud 服务器
    [AVOSCloud setApplicationId:@"JX4vfLNIeHNcOQrwBa3tsXyc-gzGzoHsz" clientKey:@"N2ssad2DcmwL6iOGbAK8XUmm"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    /**------------------百度地SDK---------------------------------------*/
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"zsY4PeegbkyBi1mGaWGdXQrVK6zAfYEi"  generalDelegate:nil];
    if (!ret) {
//        NSLog(@"manager start failed!");
    }
    //设置跟控制器
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    /**--------------------------------*/
    //    1, 从info.plist文件中读取当前的外部版本号
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    // 2, 读取自己上一次运行引导页保存的版本号
    NSString *strVersionMine = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldVersionKey"];
    if ([strVersion isEqualToString:strVersionMine]) {
        [self loadMainViewController];
    }else{
    
        [self loadMainController];
    
        self.window.backgroundColor = [UIColor lightTextColor];
    }
   
    [self.window makeKeyAndVisible];
    
    return YES;
}


// 直接跳转到主控制器
-(void)loadMainController{

    [_window setRootViewController:[[Guidevc alloc]init]];
}
-(void)loadMainViewController{
    rootViewController *controllerVC = [[rootViewController alloc]init];
    self.window.rootViewController = controllerVC;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)NCRecordedInformationVC{
      [self.time setFireDate:[NSDate date]];
    if (_time == 0) {
        _time = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(runAciton) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop]addTimer:_time forMode:NSRunLoopCommonModes];
//        NSLog(@"开始计时");
        
    }else{
        
        
    }
    

}
-(void)runAciton{
    __persent ++;
    if (__persent == 100) {
        __seconds++;
        __persent = 0;
    }
    if (__seconds == 60) {
        __minutes ++;
        __seconds = 0;
    }
    if (__minutes == 60) {
        __hours ++ ;
        __minutes = 0;
    }
    _strTime =[NSString stringWithFormat:@"%02ld:%02ld:%02ld",__hours,__minutes,__seconds];

    if (_currentValue) {
        _currentValue(_strTime);
    }
 }


@end
