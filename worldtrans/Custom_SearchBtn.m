//
//  Custom_SearchBtn.m
//  worldtrans
//
//  Created by itdept on 14-4-30.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "Custom_SearchBtn.h"

@implementation Custom_SearchBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//使用storyboard的时候，按钮的初始化调用此方法
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.3 green:0.278 blue:0.957 alpha:1],[UIColor colorWithRed:0.114 green:0.712 blue:0.843 alpha:1]] mutableCopy];
        UIImage *bagImage=[self fn_buttonBagFromColor:colorArray];
        [self setBackgroundImage:bagImage forState:UIControlStateNormal];
        self.layer.cornerRadius=4;
        self.layer.masksToBounds=YES;
    }
    return self;
}

-(UIImage*)fn_buttonBagFromColor:(NSArray*)colors{
    NSMutableArray *mutableArr=[NSMutableArray array];
    for (UIColor *color in colors) {
        [mutableArr addObject:(id)color.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)mutableArr, NULL);
    CGPoint start= CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(0.0, self.frame.size.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}
*/

@end
