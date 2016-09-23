//
//  NCToolCell.h
//  健康骑行
//
//  Created by qingyun on 16/9/17.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCToolCell : UITableViewCell
/*骑行时间**/
@property (weak, nonatomic) IBOutlet UILabel *lalCycingTimer;
/*骑行里程**/
@property (weak, nonatomic) IBOutlet UILabel *lalMileage;
/*休息时间**/
@property (weak, nonatomic) IBOutlet UILabel *lalRengTimer;
/*平均时间**/
@property (weak, nonatomic) IBOutlet UILabel *lalVelocity;
+(instancetype)cellWillTableView:(UITableView *)tableView;

@end
