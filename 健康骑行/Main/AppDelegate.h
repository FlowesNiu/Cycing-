//
//  AppDelegate.h
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapView.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    UIWindow *winod;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
 
}
@property (nonatomic, copy)void (^currentValue)(NSString *timeStr);
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSTimer *time;
@property(nonatomic,strong) NSString *strTime;
@property(nonatomic,assign)NSInteger _seconds;
@property(nonatomic,assign)NSInteger _persent;
@property(nonatomic,assign)NSInteger _minutes;
@property(nonatomic,assign)NSInteger _hours;

-(void)loadMainViewController;
-(void)NCRecordedInformationVC;

@end

