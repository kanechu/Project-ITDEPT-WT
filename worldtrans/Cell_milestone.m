
//
//  Cell_milestone.m
//  worldtrans
//
//  Created by itdept on 2/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "Cell_milestone.h"
#import "Res_color.h"
@implementation Cell_milestone

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect cellframe=self.frame;
    CGRect imageFrame=CGRectMake(_ipic_desc_status.frame.origin.x, (cellframe.size.height-_ipic_desc_status.frame.size.height)/2, _ipic_desc_status.frame.size.width, _ipic_desc_status.frame.size.height);
    [_ipic_desc_status setFrame:imageFrame];
    [_ipic_row_status setFrame:CGRectMake(_ipic_row_status.frame.origin.x, _ipic_row_status.frame.origin.y, _ipic_row_status.frame.size.width, _maxRow_height+2)];
    
    CGRect numFrame=CGRectMake(_ilb_row_num.frame.origin.x,(cellframe.size.height-_ilb_row_num.frame.size.height)/2, _ilb_row_num.frame.size.width, _ilb_row_num.frame.size.height);
    [_ilb_row_num setFrame:numFrame];
    
    _ipic_desc_status.layer.cornerRadius=2;
    _ipic_desc_status.layer.masksToBounds=YES;
    _ipic_desc_status.layer.borderWidth=3;
    if (_flag_milestone_finished==1) {
        _ipic_desc_status.layer.backgroundColor=COLOR_BG_RED.CGColor;
        
        _ipic_desc_status.layer.borderColor=[UIColor redColor].CGColor;
    }
    if (_flag_milestone_finished==0) {
        _ipic_desc_status.layer.backgroundColor=COLOR_BG_GRAY.CGColor;
        _ipic_desc_status.layer.borderColor=[UIColor grayColor].CGColor;
    }
    if (_flag_milestone_type==0) {
        [_ilb_status_desc setFrame:CGRectMake(_ipic_desc_status.frame.origin.x+2, _ilb_status_desc.frame.origin.y, 265, _ilb_status_desc.frame.size.height)];
        [_ilb_status_remark setFrame:CGRectMake(_ipic_desc_status.frame.origin.x+2,_ilb_status_remark.frame.origin.y, 265, _ilb_status_remark.frame.size.height)];
        _ipic_desc_status.hidden=YES;
    }else{
        _ipic_desc_status.hidden=NO;
    }
    
}

@end
