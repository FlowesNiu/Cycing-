//
//  NCAgeVC.h
//  健康骑行
//
//  Created by qingyun on 16/9/8.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCAgeVC : UIViewController
@property(nonatomic,copy)void(^ageblock)(NSString *strAge);
@end
