//
//  NCChangeConditions.m
//  健康骑行
//
//  Created by qingyun on 16/8/24.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCChangeConditions.h"
#import "NCLogin.h"
#import "NCPersonager.h"
//#import "NCRegister.h"
//#import "NCHeightVC.h"

@interface NCChangeConditions ()
@property (strong, nonatomic) IBOutlet UILabel *lalTime;
@property (strong, nonatomic) IBOutlet UIButton *btnSkip;

@property(nonatomic,strong)UIAlertController *alertCtr;
@property(nonatomic,strong)NSTimer *time;
@property(nonatomic,assign)NSInteger _persent;
@end


@implementation NCChangeConditions
-(void)viewDidLoad{

    if (_time == nil) {
        _time = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(runsen) userInfo:nil repeats:YES];
          [[NSRunLoop currentRunLoop]addTimer:_time forMode:NSRunLoopCommonModes];
//        NSLog(@"开始计时");
    }
}
-(void)runsen{
     __persent =3;
    __persent -=1;
    if (  __persent == 0 ) {
        [_time invalidate];
        _time = nil;
        _lalTime.text = @"";
        [self skip];
    }
    //动态改变开始时间
    NSString *strTime = [NSString stringWithFormat:@"%ld秒",__persent];
    _lalTime.text = strTime;
    
    
}


- (IBAction)btnSkip:(id)sender {
    [self skip];
}



-(void)skip{
    NCPersonager *persona = [[NCPersonager alloc]init];
    [self.navigationController pushViewController:persona animated:YES];
    


}
@end
