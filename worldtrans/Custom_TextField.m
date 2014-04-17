//
//  Custom_TextField.m
//  worldtrans
//
//  Created by itdept on 14-4-17.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "Custom_TextField.h"

@implementation Custom_TextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.*/

- (void)drawRect:(CGRect)rect
{
    [self.layer addSublayer:[self fn_shadow_background]];
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius=3;
    self.layer.borderWidth=1;
}
-(CAGradientLayer*)fn_shadow_background{
    CAGradientLayer *newShadow=[[CAGradientLayer alloc]init];
    CGRect newShadowFrame=CGRectMake(0, 0, 320, 20);
    newShadow.frame=newShadowFrame;
    //添加渐变的颜色组合
    newShadow.colors=[NSArray arrayWithObjects:(id)[UIColor lightGrayColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
    return newShadow;
}

@end
