//
//  NCWeightVC.m
//  健康骑行
//
//  Created by qingyun on 16/8/24.
//  Copyright © 2016年 牛广道. All rights reserved.
//体重

#import "NCWeightVC.h"
#import "NCPreserveVC.h"

@interface NCWeightVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *weightPicke;
@property(nonatomic ,strong)NSArray *arrWeight ;
@end

@implementation NCWeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"体重";
    self.arrWeight = @[@"45-55Kg",@"55-65Kg",@"65-75Kg",@"75-85Kg",];
    _weightPicke.delegate = self;
    _weightPicke.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma maek -----uipickerViewDelegate



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrWeight.count;
    
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //    NSLog(@"hahahaha%@",self.arrHeight[row]);
    if (self.weightblock) {
        _weightblock (self.arrWeight[row]);
    }
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:self.arrWeight[row] forKey:@"weightVC"];
    return self.arrWeight[row];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
//    NSLog(@"%@",[NSString stringWithFormat:@"%ld",row]);
    
}

- (IBAction)btnWeightNext:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
