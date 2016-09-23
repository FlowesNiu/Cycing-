//
//  NCAgeVC.m
//  健康骑行
//
//  Created by qingyun on 16/9/8.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCAgeVC.h"

@interface NCAgeVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *agePick;
@property (strong, nonatomic) IBOutlet UIButton *btnAge;
@property(nonatomic,strong)NSArray *arrAge;
@end

@implementation NCAgeVC

//创建数据源
- (void)createDataSource
{
    self.arrAge = @[@"15岁以下",@"16-20岁",@"21-25岁",@"26-30岁",@"31-35岁",@"36-40岁",@"41-45岁",@"46-50岁",@"50岁以上"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSource];
    // Do any additional setup after loading the view.
    _agePick.delegate = self;
    _agePick.dataSource = self;
}
//pickView中组建的个数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//pickView组建中row的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        return self.arrAge.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.ageblock) {
        self.ageblock(self.arrAge[row]);
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.arrAge[row] forKey:@"ageVC"];
    return self.arrAge[row];

}
- (IBAction)btnAge:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
