//
//  MapAnnotation.h
//  worldtrans
//
//  Created by itdept on 14-4-3.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotation : NSObject<MKAnnotation>
//街道信息属性
@property (nonatomic, copy) NSString *streetAddress;
//城市信息属性
@property (nonatomic, copy) NSString *city;
//州、省、市信息
@property (nonatomic, copy) NSString *state;
//邮编
@property (nonatomic, copy) NSString *zip;
//地理坐标
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end
