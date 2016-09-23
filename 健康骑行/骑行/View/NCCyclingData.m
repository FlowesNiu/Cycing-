//
//  NCCyclingData.m
//  健康骑行
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCCyclingData.h"
#import "NCRecordCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "NCRecordedInformationVC.h"
@interface NCCyclingData ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *arrMation;

@end

@implementation NCCyclingData
//懒加载数组
-(NSMutableArray *)arrMation{
    if (_arrMation) {
        return _arrMation;
    }
    _arrMation = [NSMutableArray array];

    AVQuery *query = [AVQuery queryWithClassName:@"userInfoMation"];
    [query whereKey:@"userName" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        NSLog(@"%@",objects);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_arrMation addObjectsFromArray:objects];
            });
    }];

    return _arrMation;

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self arrMation];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  self.tableView .estimatedRowHeight = 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    int Count=self.arrMation.count;
    return self.arrMation.count;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NCRecordCell *cell = [NCRecordCell cellWillTableView:tableView];
//    cell.textLabel.text = self.arrMation[indexPath.row];
//    return cell;
    static NSString *str = @"NCRecordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
cell.textLabel.text = @"1234567";
    return cell;
}

@end
