//
//  TipView.m
//  worldtrans
//
//  Created by itdept on 15/5/16.
//  Copyright (c) 2015年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "TipView.h"
#define LABEL_HEIGHT 42
@implementation TipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)fn_creat_label{
    UILabel *ilb_alert=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2-108, self.frame.size.width, LABEL_HEIGHT)];
    ilb_alert.lineBreakMode=NSLineBreakByCharWrapping;
    ilb_alert.numberOfLines=0;
    ilb_alert.textAlignment=NSTextAlignmentCenter;
    ilb_alert.font=[UIFont systemFontOfSize:24];
    ilb_alert.textColor=[UIColor lightGrayColor];
    ilb_alert.text=_str_msg;
    [self addSubview:ilb_alert];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self fn_creat_label];
}
@end
