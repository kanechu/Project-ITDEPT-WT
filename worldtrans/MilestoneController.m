//
//  MilestoneController.m
//  worldtrans
//
//  Created by itdept on 2/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "MilestoneController.h"
#import "RespMilestone.h"
#import "Cell_milestone.h"
#import "Res_color.h"
#import "Web_base.h"
#import "DB_login.h"
#import "DB_sypara.h"
#import "MBProgressHUD.h"
#import "Calculate_lineHeight.h"

@interface MilestoneController ()
@property(nonatomic,strong)Calculate_lineHeight *cal_obj;

@property(nonatomic) NSInteger ii_max_row;
@property(nonatomic) NSInteger ii_last_status_row;

@property (strong,nonatomic) NSMutableArray *ilist_milestone;
//用这个来判断是否显示ms image
@property(nonatomic,assign)NSInteger flag_milestone_type;
//存储图片
@property(nonatomic,strong)NSMutableArray *alist_images;

@end

@implementation MilestoneController

@synthesize is_docu_type;
@synthesize is_docu_uid;
@synthesize ilist_milestone;
@synthesize ii_last_status_row;
@synthesize ii_max_row;
@synthesize cal_obj;
@synthesize flag_milestone_type;
@synthesize alist_images;

- (void)viewDidLoad
{
    [self fn_get_milestone_style];
    CheckNetWork *check_obj=[[CheckNetWork alloc]init];
    if ([check_obj fn_isPopUp_alert]==NO) {
        [self fn_get_data:is_docu_type :is_docu_uid];
    }
    cal_obj=[[Calculate_lineHeight alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -由sypara的para_code控制，是否显示图片
- (void)fn_get_milestone_style{
    flag_milestone_type=0;
    DB_sypara *db_sypara=[[DB_sypara alloc]init];
    NSMutableArray *alist_result=[db_sypara fn_get_sypara_data];
    for (NSMutableDictionary *idic in alist_result) {
        NSString *para_code=[self fn_cut_space:[idic valueForKey:@"para_code"]];
        NSString *data1=[idic valueForKey:@"data1"];
        if ([para_code isEqualToString:@"ANDRDUSEMSIMAGE"] && [data1 isEqualToString:@"1"]) {
            flag_milestone_type=1;
        }
    }
}
-(NSString*)fn_cut_space:(NSString*)str{
    NSString *subStr=str;
    if ([str rangeOfString:@" "].length>0) {
        NSRange range=[str rangeOfString:@" "];
        subStr=[str substringToIndex:range.location];
    }
    return subStr;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ilist_milestone count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    NSString *ls_status_desc = @"",*ls_act_status_date = @"",*ls_is_finished=@"";
    bool lb_done = NO;
    
    static NSString *ls_TableIdentifier = @"cell_milestone_detail";
    Cell_milestone *cell = (Cell_milestone *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    
    cell.flag_milestone_type=flag_milestone_type;
    
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    ldict_dictionary = [ilist_milestone objectAtIndex:indexPath.row];    // Configure Cell
    cell.ipic_desc_status.image=[alist_images objectAtIndex:indexPath.row];
    ls_status_desc =[ldict_dictionary valueForKey:@"status_desc"];
    ls_act_status_date =[ldict_dictionary valueForKey:@"act_status_date"];
    ls_is_finished=[ldict_dictionary valueForKey:@"is_finished"];
    cell.flag_milestone_finished=[ls_is_finished integerValue];
    cell.ilb_status_desc.text = ls_status_desc;
    cell.ilb_row_num.text = [@(indexPath.row) stringValue];
    if (indexPath.row < self.ii_last_status_row) {
        lb_done = YES;
    }
    
    // letter value
    if (lb_done) {
        // pic setting
        if (indexPath.row == 0 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"readed_start"]];
        } else if (indexPath.row == self.ii_max_row-1 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"readed_end"]];
        } else {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"readed"]];
        }
        cell.ilb_status_remark.text = [NSString stringWithFormat:@"%@ %@ %@", @"(Done)", ls_act_status_date
                                       , [ldict_dictionary valueForKey:@"remark"]];
        [cell.ilb_status_desc setTextColor:COLOR_LIGHT_GREEN];
        [cell.ilb_status_remark setTextColor:COLOR_AQUA];
        [cell.ilb_row_num setTextColor:[UIColor redColor]];
    } else {
        // pic setting
        if (indexPath.row == 0 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"unread_start"]];
        } else if (indexPath.row == self.ii_max_row-1 ) {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"unread_end"]];
        }
        else {
            [cell.ipic_row_status setImage:[UIImage imageNamed:@"unread"]];
        }
        cell.ilb_status_remark.text=@"";
        [cell.ilb_status_desc setTextColor:[UIColor grayColor]];
        [cell.ilb_status_remark setTextColor:[UIColor grayColor]];
        [cell.ilb_row_num setTextColor:[UIColor grayColor]];
    }
    CGFloat width=cell.ilb_status_desc.frame.size.width;
    CGFloat width1=cell.ilb_status_remark.frame.size.width;
    if (flag_milestone_type==0) {
        width=width+cell.ipic_desc_status.frame.size.width;
        width1=width1+cell.ipic_desc_status.frame.size.width;
    }
    
    CGFloat height=[cal_obj fn_heightWithString:cell.ilb_status_desc.text font:cell.ilb_status_desc.font constrainedToWidth:width];
    if (height<21) {
        height=21;
    }
    [cell.ilb_status_desc setFrame:CGRectMake(cell.ilb_status_desc.frame.origin.x, cell.ilb_status_desc.frame.origin.y, cell.ilb_status_desc.frame.size.width,height)];
    
    CGFloat height1=[cal_obj fn_heightWithString:cell.ilb_status_remark.text font:cell.ilb_status_remark.font constrainedToWidth:width1];
    if (height1<21) {
        height1=21;
    }
    
    [cell.ilb_status_remark setFrame:CGRectMake(cell.ilb_status_remark.frame.origin.x, cell.ilb_status_desc.frame.origin.y+height, cell.ilb_status_remark.frame.size.width,height1)];
    [cell.ipic_row_status setFrame:CGRectMake(cell.ipic_row_status.frame.origin.x, cell.ipic_row_status.frame.origin.y, cell.ipic_row_status.frame.size.width, height+height1+17)];   
    
    return cell;
}
#pragma mark -UITableViewDelegate
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_milestone_hdr";
    Cell_milestone *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1 )
        return 0.000001f;
    else return 44; // put 22 in case of plain one..
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *ls_TableIdentifier = @"cell_milestone_detail";
    Cell_milestone *cell = (Cell_milestone *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    NSMutableDictionary *ldict_dictionary = [ilist_milestone objectAtIndex:indexPath.row];
    NSString *ls_status_desc =[ldict_dictionary valueForKey:@"status_desc"];
    NSString *ls_act_status_date =[ldict_dictionary valueForKey:@"act_status_date"];
    NSString *ls_remark = [NSString stringWithFormat:@"%@ %@ %@", @"(Done)", ls_act_status_date
                           , [ldict_dictionary valueForKey:@"remark"]];
    CGFloat width=cell.ilb_status_desc.frame.size.width;
    CGFloat width1=cell.ilb_status_remark.frame.size.width;
    if (flag_milestone_type==0) {
        width=width+cell.ipic_desc_status.frame.size.width;
        width1=width1+cell.ipic_desc_status.frame.size.width;
    }
    CGFloat height=[cal_obj fn_heightWithString:ls_status_desc font:cell.ilb_status_desc.font constrainedToWidth:width];
    
    if (height<21) {
        height=21;
    }
    CGFloat height1=[cal_obj fn_heightWithString:ls_remark font:cell.ilb_status_remark.font constrainedToWidth:width1];
    if (height1<21) {
        height1=21;
    }

    return height+height1+17;
}
- (void)fn_get_milestone_info {
    int nextTag = 1;
    self.ii_max_row = [ilist_milestone count];
    for (NSMutableDictionary *lmap_data in ilist_milestone) {
        if ([[lmap_data valueForKey:@"is_finished"]isEqualToString:@"1"]) {
            self.ii_last_status_row = nextTag;
        }
        nextTag++;
    }
}
#pragma mark -NetWork Request
- (void) fn_get_data: (NSString*)as_docu_type :(NSString*)as_docu_uid
{
    //显示loading
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RequestContract *req_form = [[RequestContract alloc] init];
    DB_login *dbLogin=[[DB_login alloc]init];
    req_form.Auth =[dbLogin WayOfAuthorization];
    
    SearchFormContract *search1 = [[SearchFormContract alloc]init];
    search1.os_column = @"docu_type";
    search1.os_value = as_docu_type;
    
    SearchFormContract *search2 = [[SearchFormContract alloc]init];
    search2.os_column = @"docu_uid";
    search2.os_value = as_docu_uid;
    
    req_form.SearchForm = [NSSet setWithObjects:search1,search2, nil];
    
    Web_base *web_base = [[Web_base alloc] init];
    web_base.il_url =STR_MILESTONE_URL;
    web_base.iresp_class =[RespMilestone class];
    
    web_base.ilist_resp_mapping =[NSArray arrayWithPropertiesOfObject:[RespMilestone class]];
    web_base.iobj_target = self;
    web_base.isel_action = @selector(fn_save_milestone_list:);
    [web_base fn_get_data:req_form];
    
}
-(void)fn_save_milestone_list:(NSMutableArray*)alist_result{
    ilist_milestone = alist_result;
    alist_images=[[NSMutableArray alloc]initWithCapacity:1];
    for (RespMilestone *milestone in alist_result) {
        NSString *pic_url=milestone.status_pic_url;
        NSURL *url=[NSURL URLWithString:pic_url];
        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        if (image==nil) {
            image=[[UIImage alloc]init];
        }
        [alist_images addObject:image];
    }    
    [self fn_get_milestone_info];
    [self.tableView reloadData];
    //隐藏loading
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   
}

@end
