//
//  NCNewModel.h
//  健康骑行
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCNewModel : NSObject
/** 骑行时间 */
@property (nonatomic, copy) NSString *strCycingTime;

/** 行驶里程 */
@property (nonatomic, copy) NSString *strMileage;

/** 休息时间 */
@property (nonatomic, copy) NSString *strrenngTime;

/** 平均速度 */
@property (nonatomic, copy) NSString *straverage;

/** 模型的初始化方法 */
+ (instancetype)userModelWithDictionary:(NSDictionary *)dicData;

@end
