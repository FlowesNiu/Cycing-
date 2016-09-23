//
//  NCRecordedInformationVC.h
//  健康骑行
//
//  Created by qingyun on 16/8/29.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCRecordedInformationVC : UIViewController
/**定义一个block 传递时间*/
@property(nonatomic,copy)void(^NCCycingBlock)(NSString *lalCyclingTime);
@property (nonatomic, strong) NSString *zongLicheng;
-(void)dianjizanting;
@end
