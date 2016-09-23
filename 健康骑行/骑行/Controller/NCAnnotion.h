//
//  NCAnnotion.h
//  健康骑行
//
//  Created by qingyun on 16/9/3.
//  Copyright © 2016年 牛广道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

typedef enum :NSUInteger{
    kAnnotationBegin,
    kAnnotationNow,
    kAnnotationPause,
    kAnnotationEnd
}AnnotionType;
@interface NCAnnotion : NSObject<BMKAnnotation>
//遵守的annotion协议
@property(nonatomic)CLLocationCoordinate2D coordinate;
@property(nonatomic)AnnotionType type;
@end
