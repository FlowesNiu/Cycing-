//
//  NCCycling.m
//  健康骑行
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//骑行_地图

#import "NCCycling.h"
#import <Masonry/Masonry.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//跳转到记录的界面
#import "NCRecordedInformationVC.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "NCAnnotion.h"

@interface NCCycling ()<CLLocationManagerDelegate,BMKMapViewDelegate>
/*定位的管理类**/
//@property (strong, nonatomic) IBOutlet UIButton *btnAction;
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)CLLocation *nowLocation;
/*当前位置的标注**/
@property(nonatomic,strong)NCAnnotion *nowAnnotion;

/*所经过所有的点**/
@property(nonatomic,strong)NSMutableArray *allLocations;
/*初始化地图**/
@property(nonatomic,strong)BMKMapView *_mapView;
/*当前速度**/
@property (strong, nonatomic) IBOutlet UILabel *lalReadCV;
@property (weak, nonatomic) IBOutlet UIView *isView;


@property (strong, nonatomic) IBOutlet UILabel *lalMileage;
/*提示信息**/
@property(nonatomic,strong)UIAlertController *alertCtr;

//跳转到记录界面的btn
@property (strong, nonatomic) IBOutlet UIButton *btnSkip;
@property(nonatomic,strong)NSString *lal;
@property (strong, nonatomic) IBOutlet UIView *_bottomView;
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic)double allDistance;
@property(nonatomic,strong)NSString *zonglicheng;
@end

@implementation NCCycling
-(void)viewWillAppear:(BOOL)animated{
    _app= [[UIApplication sharedApplication]delegate];
    __weak NCCycling *vc = self;
    [_app setCurrentValue:^(NSString *strTime) {
        vc.lalDuration.text = strTime;
    }];
    [self._mapView viewWillAppear];
    __mapView.delegate = self;//不用的时候需要置于nil。否则影响内存释放
    
    }
-(void)viewWillDisappear:(BOOL)animated{
    [self._mapView viewWillDisappear];
    __mapView.delegate = nil;
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =  @"骑行";
    
    //配置laction manager
    [self loadDefaultSetting];
    self.allLocations = [NSMutableArray array];
    self._mapView.delegate = self;
//    _allLocations = [NSMutableArray array];
    
    
}
-(void)loadDefaultSetting{
    //配置locationmanager
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    //申请授权
    if (self.locationManager) {
        [self.locationManager requestAlwaysAuthorization];
//        NSLog(@"授权成功");
    }else{
//        NSLog(@"授权失败%d",[CLLocationManager authorizationStatus]);
    
    }
    
    //配置定位的属性
    self.locationManager.distanceFilter = 10.f;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters ;
    
    //初始化地图
    __mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];

    self.view = __mapView;
    [self.view addSubview:self.isView];
    [__mapView addSubview:self.btnSkip];
    [_isView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__mapView).offset(60);
        make.leading.trailing.equalTo(__mapView);
        make.height.equalTo(@(70));
    }];
    [__mapView addSubview:self._bottomView];
    [__bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(__mapView);
        make.bottom.equalTo(self.view).offset(-40);
        make.height.equalTo(@(50));
    }];
    
    [_btnSkip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(__mapView);
        make.centerY.equalTo(__mapView);
        
    }];
    
}
//uibarbuttonitem addtarget的方法
-(void)customLocation{

}

//开始定位
- (IBAction)btnAction:(id)sender {
       NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strDef = [defaults objectForKey:@"txtUserName"];
    if (strDef){
    [_app NCRecordedInformationVC];
        [self.locationManager startUpdatingLocation];
            }else{
[self alertActionWithMessage:@"您还没有登陆,请先点击个人进行登陆"];
            }
}
//暂停定位
- (IBAction)btnSuspend:(id)sender {
//    NCRecordedInformationVC * rec = [[NCRecordedInformationVC alloc]init];
    
//    [_app.time setFireDate:[NSDate date]];
    //停止定位
    [self.locationManager stopUpdatingLocation];
    NCAnnotion *anno = [[NCAnnotion alloc]init];
    //当前的位置点
    anno.coordinate = self.nowLocation.coordinate;
    //设置点得状态
    anno.type = kAnnotationPause;
    [self._mapView addAnnotation:anno];
}
//结束定位
- (IBAction)btnEnd:(id)sender {
    
    [self.locationManager stopUpdatingLocation];
    NCAnnotion *anno = [[NCAnnotion alloc]init];
    //当前的位置点
    anno.coordinate = self.nowLocation.coordinate;
    //设置点得状态
    anno.type = kAnnotationEnd;
    [self._mapView addAnnotation:anno];
}
#pragma mark -location delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //取返回数据的最后一点
    CLLocation *locaTion = locations.lastObject;
    //排除返回数据的最后一个
    if (locaTion.horizontalAccuracy > 100 || locaTion.horizontalAccuracy < 0) {
        //精度太差
       return;
    }
//如果属性不存在。则之前没有返回过点
    if (!self.nowLocation) {
        BMKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        BMKCoordinateRegion region;
        region.center = locaTion.coordinate;
        region.span = span;
        [self._mapView setRegion:region animated:YES];
        
         //第一个点为开始点
        NCAnnotion *bengin = [[NCAnnotion alloc]init];
        bengin.coordinate = locaTion.coordinate;
        bengin.type = kAnnotationBegin;
        [self._mapView addAnnotation:bengin];
    }
    NCAnnotion *nowAnno = [[NCAnnotion alloc]init];
    nowAnno.coordinate = locaTion.coordinate;
    nowAnno.type = kAnnotationNow;
    [self._mapView addAnnotation:nowAnno];
    // 删除上一次的位置
    if (self.nowAnnotion) {
        [self._mapView removeAnnotation:self.nowAnnotion];
//        [self._mapView removeAnnotation:self.nowLocation];
    }
    //保留用作一下一次取消
    self.nowAnnotion = nowAnno;
//    NSLog(@"%@",locaTion);
    self.nowLocation =locaTion;
    //将所有点保存
    [self.allLocations addObject:locaTion];
    //初始化覆盖层模型对象
    //声明一个结构体数组
    CLLocationCoordinate2D *coors = malloc(sizeof(CLLocationCoordinate2D) * self.allLocations.count);
    for (NSUInteger index = 0; index < self.allLocations.count ; index ++) {
        //填充数组
        coors[index] = [self.allLocations[index]coordinate];
    }
    //曲线覆盖层数据
    BMKPolyline *line = [BMKPolyline polylineWithCoordinates:coors count:self.allLocations.count];
    [self._mapView addAnnotation:line];
}
#pragma mark__-mapkit delegate


//返回标注的delegate的方法
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[NCAnnotion class]]) {
    //定义复用的标识符
        static NSString *identifier = @"ncAnnotation";
        NCAnnotion *anno = (NCAnnotion *)annotation;
        BMKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (!view) {
            view = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
            
        }
        //绑定数据
        switch (anno.type) {
            case kAnnotationBegin:
            {//map_start_icon
                view.image = [UIImage imageNamed:@"currentlocation"];
                view.centerOffset = CGPointMake(0, -12);
                }
                break;
            case kAnnotationNow:
            {
                view.image = [UIImage imageNamed:@"currentlocation"];
                view.centerOffset = CGPointZero;

            
            }
                break;
            case kAnnotationPause:
    
            {
                view.image = [UIImage imageNamed:@"map_susoend_icon"];
                view.centerOffset = CGPointMake(0, -12);
            }

                break;
            case kAnnotationEnd:
            {
                view.image = [UIImage imageNamed:@"map_stop_icon"];
                view.centerOffset = CGPointMake(0, -12);
            }
                break;
                
            default:
                break;
        }
        return view;
    }
    return nil;

}
//返回覆盖层
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{

//判断模型数据类型
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *view = [[BMKPolylineView alloc]initWithPolyline:overlay];
        view.lineWidth = 3.f;
        view.strokeColor = [UIColor blueColor];
        return view;
    }
    
    return nil;

}
    /** 提示信息*/
    -(void)alertActionWithMessage:(NSString *)message {
        self.alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [self.alertCtr addAction:alertAction];
        [self presentViewController:self.alertCtr animated:YES completion:nil];
    }



//计算总里程
-(void)RunningDistanceNowlocation:(CLLocation *)Nowlocation beforeLocation:(CLLocation *)beforeLocation{
    double distance = [Nowlocation distanceFromLocation:beforeLocation];
//    NSLog(@"相对距离%lf",distance);
    self.allDistance += distance;
//    NSLog(@"总距离%lf",self.allDistance);
        self.zonglicheng = [NSString stringWithFormat:@"%.2lf",self.allDistance / 1000];
//    NSLog(@"self。总里程%@",self.zonglicheng);
    

    
 }
- (IBAction)btnMapSkip:(id)sender {
    NCRecordedInformationVC *recordInfo = [[NCRecordedInformationVC alloc]initWithNibName:@"NCRecordedInformationVC" bundle:[NSBundle mainBundle]];
    [self RunningDistanceNowlocation:self.nowLocation beforeLocation:nil];
    recordInfo.zongLicheng = self.zonglicheng;
    [self.navigationController pushViewController:recordInfo animated:YES];
}
    @end
