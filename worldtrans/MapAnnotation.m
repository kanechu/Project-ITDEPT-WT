//
//  MapAnnotation.m
//  worldtrans
//
//  Created by itdept on 14-4-3.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
- (NSString *)title {
    return @"Here is:";
}
- (NSString *)subtitle {
    
    NSMutableString *ret = [NSMutableString new];
    if (_state)
        [ret appendString:_state];
    if (_city)
        [ret appendString:_city];
    if (_city && _state)
        [ret appendString:@", "];
    if (_streetAddress && (_city || _state || _zip))
        [ret appendString:@" • "];
    if (_streetAddress)
        [ret appendString:_streetAddress];
    if (_zip)
        [ret appendFormat:@", %@", _zip];
    
    return ret;
}

@end
