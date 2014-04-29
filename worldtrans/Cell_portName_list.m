//
//  Cell_portName_list.m
//  worldtrans
//
//  Created by itdept on 14-4-23.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "Cell_portName_list.h"

@implementation Cell_portName_list
@synthesize ilb_portName;
@synthesize ilb_desc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        ilb_portName=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 250, 21)];
        ilb_portName.font=[UIFont systemFontOfSize:15];
        ilb_portName.textAlignment=NSTextAlignmentLeft;
        ilb_portName.textColor=[UIColor whiteColor];
        [self addSubview:ilb_portName];
        ilb_desc=[[UILabel alloc]initWithFrame:CGRectMake(20, 21, 250, 39)];
        ilb_desc.font=[UIFont systemFontOfSize:14];
        ilb_desc.textAlignment=NSTextAlignmentLeft;
        ilb_desc.textColor=[UIColor grayColor];
        ilb_desc.numberOfLines=0;
        [self addSubview:ilb_desc];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
