//
//  NCWeightVC.h
//  健康骑行
//
//  Created by qingyun on 16/8/24.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCWeightVC : UIViewController
@property(nonatomic,copy)void (^weightblock)(NSString *str);
@end
