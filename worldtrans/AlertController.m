//
//  AlertController.m
//  worldtrans
//
//  Created by itdept on 2/26/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AlertController.h"
#import "Cell_alert_list.h"
#import "Res_color.h"
#import "DB_alert.h"
#import "NSString.h"
#import "ExhblHomeController.h"
#import "AehblHomeController.h"

@interface AlertController ()

@property (strong,nonatomic) NSMutableArray *ilist_alert;
@property (strong,nonatomic) NSMutableArray *today_alert;
@property (strong,nonatomic) NSMutableArray *previous_alert;
@property (strong,nonatomic) NSMutableDictionary *deleteDic;
@property ( nonatomic) UIButton *cancleButton;

@end

@implementation AlertController

@synthesize ilist_alert;
@synthesize deleteDic;
@synthesize cancleButton;
@synthesize today_alert;
@synthesize previous_alert;
-(void)initDic{
    self.deleteDic=[NSMutableDictionary dictionaryWithCapacity:10];
    self.today_alert=[NSMutableArray arrayWithCapacity:10];
    self.previous_alert=[NSMutableArray arrayWithCapacity:10];
}
- (void)viewDidLoad
{
   
    [self initDic];
    self.view.backgroundColor = [UIColor blackColor];
    //初始nil文件，获取alert
    [self fn_get_data];
    //十分钟检查一次是否有新通知
    [NSTimer scheduledTimerWithTimeInterval: 600.0 target: self
                                   selector: @selector(reloadNeWData) userInfo: nil repeats: YES];
    
    //当点击编辑的时候，显示toolbar
    UIBarButtonItem *deleteItem=[[UIBarButtonItem alloc]initWithTitle:@"delete" style:UIBarButtonItemStyleBordered target:self action:@selector(DeleteAllSelections:)];
    NSMutableArray *arr=[NSMutableArray arrayWithObject:deleteItem];
    [self setToolbarItems:arr animated:YES];
    [[self navigationController] setToolbarHidden:YES animated:YES];
    [self fn_setExtraCellLineHidden];
   
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ilist_alert count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"cell_alert_list_hdr";
    Cell_alert_list *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    return 71;
}
#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *ls_TableIdentifier = @"cell_alert_list";
    Cell_alert_list *cell = (Cell_alert_list *)[self.tableView dequeueReusableCellWithIdentifier:ls_TableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cell_alert_list" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
    
    NSString *ls_status_desc =[ldict_dictionary valueForKey:@"status_desc"];
    NSString *ls_act_status_date =[ldict_dictionary valueForKey:@"act_status_date"];
    NSString *ls_msg_recv_date =[ldict_dictionary valueForKey:@"msg_recv_date"];
    NSString *ls_ct_type =[ldict_dictionary valueForKey:@"ct_type"];
    NSString *ls_show_no = @"";
    if ([ls_ct_type containsString:@"so"])
        ls_show_no = [@"BOOKING#: " stringByAppendingString:[ldict_dictionary valueForKey:@"so_no"]];
    else
        ls_show_no = [@"HBL#: " stringByAppendingString:[ldict_dictionary valueForKey:@"hbl_no"]];
    //检查是否为NUll，如果为NUll转换为空串，不显示出NULl
    ls_status_desc=[NSString nullConvertEmpty:ls_status_desc];
    ls_act_status_date=[NSString nullConvertEmpty:ls_act_status_date];
    ls_msg_recv_date=[NSString nullConvertEmpty:ls_msg_recv_date];
    ls_show_no=[NSString nullConvertEmpty:ls_show_no];
    
    cell.ilb_status_desc.text = ls_status_desc;
    cell.ilb_act_status_date.text = ls_act_status_date;
    cell.ilb_alert_date.text = ls_msg_recv_date;
    cell.ilb_ct_nos.text = ls_show_no;
    if ([[NSString stringWithFormat:@"%@", [ldict_dictionary valueForKey:@"is_read"]] isEqualToString:@"0"]  ) {
        cell.ilb_warningBlue.hidden=NO;
        cell.ilb_warningBlue.image=[UIImage imageNamed:@"warning_blue"];
        
        
    }else{
        cell.ilb_warningBlue.image=nil;
        cell.ilb_warningBlue.hidden=YES;
    }
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor blackColor];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}
- (void)tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ([self.cancleButton.titleLabel.text isEqualToString:@"Cancel"]) {
        [self.deleteDic setObject:indexPath forKey:[ilist_alert objectAtIndex:indexPath.row]];
    }else{
        NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
        ldict_dictionary = [ilist_alert objectAtIndex:indexPath.row];
        // Configure Cell
        NSString *ls_unique_id = [ldict_dictionary valueForKey:@"unique_id"];
        NSString *ls_ct_type =[[ldict_dictionary valueForKey:@"ct_type"] lowercaseString];
        if ([ls_ct_type isEqualToString:@"exhbl"]) {
            [self performSegueWithIdentifier:@"segue_exhbl_home1" sender:self];
        }else if([ls_ct_type isEqualToString:@"aehbl"]){
            [self performSegueWithIdentifier:@"segue_aehbl_home1" sender:self];
        }
        DB_alert * ldb_alert = [[DB_alert alloc] init];
        [ldb_alert fn_update_isRead:ls_unique_id];
        
        ilist_alert=[ldb_alert fn_get_all_msg];
        [self.tableView reloadData];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cancleButton.titleLabel.text isEqualToString:@"Cancel"]) {
       [self.deleteDic removeObjectForKey:[ilist_alert objectAtIndex:indexPath.row]];
        
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        
        
    }
    
}
-(void)fn_setExtraCellLineHidden{
    UIView *view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *ls_hbl_uid = @"";
    NSString *ls_so_uid = @"";
    NSString *ls_os_column = @"";
    NSString *ls_os_value = @"";
    NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    
    ldict_dictionary = [ilist_alert objectAtIndex:selectedRowIndex.row];    // Configure Cell
    ls_hbl_uid = [ldict_dictionary valueForKey:@"hbl_uid"];
    ls_so_uid = [ldict_dictionary valueForKey:@"so_uid"];
    
    if ([ls_hbl_uid length] > 0) {
        ls_os_column = @"hbl_uid";
        ls_os_value = ls_hbl_uid;
    }
    else {
        
        ls_os_column = @"so_uid";
        ls_os_value = ls_so_uid;
    }
    
    if ([[segue identifier] isEqualToString:@"segue_exhbl_home1"]) {
        ExhblHomeController *exhblHomeController = [segue destinationViewController];
        exhblHomeController.is_search_column = ls_os_column;
        exhblHomeController.is_search_value = ls_os_value;
    }else if ([[segue identifier] isEqualToString:@"segue_aehbl_home1"]){
        AehblHomeController *aehblHomeController = [segue destinationViewController];
        aehblHomeController.is_search_column = ls_os_column;
        aehblHomeController.is_search_value = ls_os_value;
    }
}

- (void) fn_get_data
{
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    today_alert=[ldb_alert fn_get_today_msg];
    previous_alert=[ldb_alert fn_get_previous_msg];
    ilist_alert=today_alert;
    
}
-(void)reloadNeWData{
    
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    if ([ldb_alert fn_get_unread_msg_count]>([previous_alert count]+[today_alert count])) {
        today_alert=[ldb_alert fn_get_today_msg];
        previous_alert=[ldb_alert fn_get_previous_msg];
        [self.tableView reloadData];
    }
}
- (IBAction)EditRow:(id)sender{
    self.cancleButton=(UIButton*)sender;
    //显示多选圆圈
    [self.tableView setEditing:YES animated:YES];
   
    [self.cancleButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(CancleAllSelections) forControlEvents:UIControlEventTouchUpInside];
    [[self navigationController] setToolbarHidden:NO animated:YES];
   
}

-(void)CancleAllSelections{
    
    //得到词典中所有Value值
    NSEnumerator *enumeratorValue=[self.deleteDic objectEnumerator];
    //快速枚举遍历所有的Value值
    for (NSObject *object in enumeratorValue) {
        NSIndexPath* indexPath=(NSIndexPath *)object;
        if (indexPath) {
            //取消已经选择的行
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    
    [deleteDic removeAllObjects];
    //隐藏多选圆圈
    [self.tableView setEditing:NO animated:YES];
    
    [self.cancleButton setTitle:@"Edit" forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(EditRow:) forControlEvents:UIControlEventTouchUpInside];
    [[self navigationController] setToolbarHidden:YES animated:YES];
}

- (void)DeleteAllSelections:(id)sender {
    [ilist_alert removeObjectsInArray:[self.deleteDic allKeys]];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:
                                            [self.deleteDic allValues]] withRowAnimation:UITableViewRowAnimationFade];
    //得到词典中所有Value值
    NSEnumerator *enumeratorValue=[self.deleteDic objectEnumerator];
    //快速枚举遍历所有的Value值
    for (NSObject *object in enumeratorValue) {
        NSIndexPath* indexPath=(NSIndexPath *)object;
        NSMutableDictionary *ldict_dictionary = [[NSMutableDictionary alloc] init];
        ldict_dictionary= [ilist_alert objectAtIndex:indexPath.row];
        // Configure Cell
        NSString *ls_unique_id = [ldict_dictionary valueForKey:@"unique_id"];
        DB_alert * ldb_alert = [[DB_alert alloc] init];
        [ldb_alert fn_delete:ls_unique_id];
      
    }
    [self.deleteDic removeAllObjects];
    //隐藏多选圆圈
    [self.tableView setEditing:NO animated:YES];
  
    [self.cancleButton setTitle:@"Edit" forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(EditRow:) forControlEvents:UIControlEventTouchUpInside];
     [[self navigationController] setToolbarHidden:YES animated:YES];
}

- (IBAction)segmentChange:(id)sender {
    UISegmentedControl *segmentCon=(UISegmentedControl*)sender;
    if (segmentCon.selectedSegmentIndex==0) {
        ilist_alert=today_alert;
    }else if (segmentCon.selectedSegmentIndex==1){
        ilist_alert=previous_alert;
    }
    [self.tableView reloadData];
}
@end
