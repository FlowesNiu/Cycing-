//
//  NCNew.h
//  健康骑行
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NCNewModel;
@interface NCNew : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *strTitle;
@property (strong, nonatomic) IBOutlet UILabel *steTime;
@property(nonatomic,strong)NCNewModel *model;
@end
