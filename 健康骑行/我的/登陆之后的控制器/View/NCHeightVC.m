//
//  NCHeightVC.m
//  健康骑行
//
//  Created by qingyun on 16/8/24.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCHeightVC.h"
#import "NCAccountUserName.h"


@interface NCHeightVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *heightPicker;
@property(nonatomic,strong)NSArray *arrHeight;
@end

@implementation NCHeightVC
//创建数据源
- (void)createDataSource
{
    self.arrHeight = @[@"150-160cm",@"160-170cm",@"170-180cm",@"180-190cm",@"190-200cm"];
   
}
- (void)viewDidLoad {
    self.title = @"身高";
    [super viewDidLoad];
    [self createDataSource];
    self.heightPicker.delegate = self;
    self.heightPicker.dataSource = self;
}
#pragma maek -----uipickerViewDelegate



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//每列的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
 
    return self.arrHeight.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.heightblock) {
        _heightblock (self.arrHeight[row]);
    }
    NSUserDefaults *defaule = [NSUserDefaults standardUserDefaults];
    [defaule setObject:self.arrHeight[row] forKey:@"heightVC"];
    return self.arrHeight[row];

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

//    NSLog(@"%@",[NSString stringWithFormat:@"%ld",row]);

}
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return ;
//}

//button的点击事件
- (IBAction)btnNext:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
