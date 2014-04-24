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
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        ilb_portName=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 250, 40)];
        ilb_portName.textAlignment=NSTextAlignmentLeft;
        [self addSubview:ilb_portName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
