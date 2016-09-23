//
//  NCNewModel.m
//  健康骑行
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import "NCNewModel.h"

@implementation NCNewModel
+(instancetype)userModelWithDictionary:(NSDictionary *)dicData{

    if (dicData == nil ||[dicData isKindOfClass:[NSNull class]])
        return nil;
        NCNewModel *model = [self new];
        model.strCycingTime = dicData[@""];
        model.strMileage = dicData[@""];
        model.strrenngTime = dicData[@""];
        model.straverage = dicData[@""];
        
    

    return model;
}
@end
