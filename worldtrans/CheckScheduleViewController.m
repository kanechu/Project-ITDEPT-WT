//
//  CheckScheduleViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-18.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "CheckScheduleViewController.h"
#import "MZFormSheetController.h"
#import "RequestContract.h"
#import "AppConstants.h"
#import "SearchFormContract.h"
#import "DB_login.h"
#import "Web_base.h"
#import "NSArray.h"
#import "RespSchedule.h"

#import "Cell_schedule_section1.h"
#import "Cell_schedule_section2_row1.h"
#import "Cell_schedule_section2_row3.h"

#import "DetailScheduleViewController.h"
#import "SearchPortNameViewController.h"
#define NUMOFSECTION 2

@interface CheckScheduleViewController ()

@end
enum NUMOFROW {
    ROW1 = 2,
    ROW2 = 3
};
@implementation CheckScheduleViewController
@synthesize ia_listData;
@synthesize iddl_drop_view;
@synthesize ilist_dateType;
@synthesize is_dataType;
@synthesize imd_searchDic;
@synthesize idp_picker;
@synthesize id_startdate;
@synthesize idic_portname;
@synthesize idic_dis_portname;
@synthesize select_row;
static NSInteger day=0;
static NSInteger flag=0;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //date type display
    ia_listData=@[@"ETD",@"ETA",@"CY Closing",@"CFS Closing"];
    //value
    ilist_dateType=@[@"ETD",@"ETA",@"CY",@"CFS"];
    imd_searchDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    _ibt_search_btn.layer.cornerRadius=3;
    [self fn_create_datePick];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)PopupView:(UIViewController*)VC Size:(CGSize) sheetSize{
    MZFormSheetController *formSheet=[[MZFormSheetController alloc]initWithViewController:VC];
    //弹出视图的大小
    formSheet.presentedFormSheetSize=sheetSize;
    formSheet.shadowRadius = 2.0;
    //阴影的不透明度
    formSheet.shadowOpacity = 0.3;
    //Yes是点击背景任何地方，弹出视图都消失,反之为No.默认为NO
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    //中心垂直，默认为NO
    formSheet.shouldCenterVertically =YES;
    formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController){}];
    
}

#pragma mark dropDownlist
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    iddl_drop_view = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    
    iddl_drop_view.delegate = self;
    
    [iddl_drop_view showInView:self.view animated:YES];
    //Set DropDown backGroundColor
    [iddl_drop_view SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.90];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    is_dataType=[ia_listData objectAtIndex:anIndex];
    select_row=anIndex;
    [self.tableView reloadData];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIView class]]) {
        [iddl_drop_view fadeOut];
    }
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
}
- (void)DropDownListViewDidCancel{
    
}
- (IBAction)fn_dropdown_btn:(id)sender {
    [iddl_drop_view fadeOut];
    [self showPopUpWithTitle:@"DateType" withOption:ia_listData xy:CGPointMake(65, 150) size:CGSizeMake(225, 220) isMultiple:NO];
}

- (IBAction)fn_click_subBtn:(id)sender {
    day--;
    if (day<0) {
        day=0;
    }
    [self.tableView reloadData];
}

- (IBAction)fn_click_addBtn:(id)sender {
    day++;
    if (day>31) {
        day=31;
    }
    [self.tableView reloadData];
}

- (IBAction)fn_click_btn:(id)sender {
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==1) {
        SearchPortNameViewController *VC=(SearchPortNameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchPortNameViewController"];
        VC.iobj_target=self;
        VC.isel_action=@selector(fn_show_portname:);
        [self PopupView:VC Size:CGSizeMake(320, 480)];
        
    }
    if (btn.tag==2) {
        if (flag==0) {
            idp_picker.hidden=NO;
            flag=1;
        }else{
            idp_picker.hidden=YES;
            flag=0;
        }
        
    }
    if (btn.tag==3) {
        SearchPortNameViewController *VC=(SearchPortNameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchPortNameViewController"];
        VC.iobj_target=self;
        VC.isel_action=@selector(fn_show_dis_portname:);
        [self PopupView:VC Size:CGSizeMake(320, 480)];
        
    }
}
-(void)fn_show_portname:(NSMutableDictionary*)portname{
    idic_portname=portname;
    [self.tableView reloadData];
}
-(void)fn_show_dis_portname:(NSMutableDictionary*)disportname{
    idic_dis_portname=disportname;
    [self.tableView reloadData];
}

#pragma mark UIDatePick
-(void)fn_create_datePick{
    //初始化UIDatePicker
    idp_picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 20, 0, 0)];
    idp_picker.backgroundColor=[UIColor blueColor];
    [idp_picker setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    //设置UIDatePicker的显示模式
    [idp_picker setDatePickerMode:UIDatePickerModeDate];
    //当值发生改变的时候调用的方法
    [idp_picker addTarget:self action:@selector(fn_change_date) forControlEvents:UIControlEventValueChanged];
    idp_picker.hidden=YES;
    [self.view addSubview:idp_picker];
    
}
-(void)fn_change_date{
    //获得当前UIPickerDate所在的日期
    NSDate *selected_date=[idp_picker date];
    id_startdate=selected_date;
    [self.tableView reloadData];
}


#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 30;
    }
    if (section==1) {
        return 20;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"Location";
    }
    if (section==1) {
        return @"Date";
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUMOFSECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return ROW1;
    }
    if (section==1) {
        return ROW2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell_schedule_section1";
        Cell_schedule_section1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section1" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        if (indexPath.row==0) {
            cell.ilb_port.text=@"Loading Port";
            
            cell.ibt_navigate_btn.tag=1;
            cell.ilb_show_portName.text=[idic_portname valueForKey:@"display"];
            if (idic_portname!=nil) {
                 [imd_searchDic setObject:[idic_portname valueForKey:@"data"] forKey:@"load_port"];
            }
           
        }
        if (indexPath.row==1) {
            [cell.ibt_navigate_btn setImage:[UIImage imageNamed:@"navigate_down"] forState:UIControlStateNormal];
            cell.ilb_port.text=@"Discharge Port";
            cell.ibt_navigate_btn.tag=3;
            cell.ilb_show_portName.text=[idic_dis_portname valueForKey:@"display"];
            if (idic_dis_portname!=nil) {
                 [imd_searchDic setObject:[idic_dis_portname valueForKey:@"data"] forKey:@"dish_port"];
            }
           
        }
        
        return cell;
    }
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row1";
            Cell_schedule_section2_row1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section2_row1" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            cell.itf_show_dateType.layer.cornerRadius=10;
            cell.itf_show_dateType.text=is_dataType;
            if (ilist_dateType!=nil) {
                [imd_searchDic setObject: [ilist_dateType objectAtIndex:select_row] forKey:@"datetype"];
            }
            
            return cell;
        }
        if (indexPath.row==1) {
            static NSString *CellIdentifier = @"Cell_schedule_section1";
            Cell_schedule_section1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section1" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            [cell.ibt_navigate_btn setBackgroundImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
            [cell.ibt_navigate_btn setImage:nil forState:UIControlStateNormal];
            cell.ibt_navigate_btn.tag=2;
            cell.ilb_port.text=@"Start Date";
            cell.ilb_show_portName.text=[self fn_DateToStringDate:id_startdate];
            [imd_searchDic setObject:cell.ilb_show_portName.text forKey:@"datefm"];
            return cell;
        }
        if (indexPath.row==2) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row3";
            Cell_schedule_section2_row3 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section2_row3" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            if ([self fn_DateToStringDate:id_startdate].length!=0 && day!=0) {
                [imd_searchDic setObject:[self fn_get_finishDate:day] forKey:@"dateto"];
               
            }else if([self fn_DateToStringDate:id_startdate].length!=0 ){
                [imd_searchDic setObject:[self fn_DateToStringDate:id_startdate] forKey:@"dateto"];
            }
             cell.ict_show_days.text=[NSString stringWithFormat:@"%d",day];
            return cell;
        }
    }
    // Configure the cell...
    return nil;
}
#pragma mark 开始日期加天数，得结束日期
-(NSString*)fn_get_finishDate:(NSInteger)_days{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval interval=60*60*24*_days;
    NSString *finishDate=[formatter stringFromDate:[id_startdate initWithTimeInterval:interval sinceDate:id_startdate]];
    return finishDate;
}
#pragma mark DateToStringDate
-(NSString*)fn_DateToStringDate:(NSDate*)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[dateFormatter stringFromDate:date];
    return str;
}

#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailScheduleViewController *VC=[segue destinationViewController];
    VC.imd_searchDic=self.imd_searchDic;
}

#pragma mark 点击search按钮后，开始按条件获取数据
- (IBAction)fn_click_searchBtn:(id)sender {
    if ([imd_searchDic count]==5) {
        [self performSegueWithIdentifier:@"segue_DetailSchedule" sender:self];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Every text box cannot be empty!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
  
}


@end
