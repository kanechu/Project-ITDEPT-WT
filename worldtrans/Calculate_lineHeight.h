//
//  Calculate_lineHeight.h
//  worldtrans
//
//  Created by itdept on 14-7-4.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculate_lineHeight : NSObject
-(CGFloat)fn_heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;
@end
