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
enum TEXTFIELD_TAG {
    TAG1 = 1,
    TAG2 ,TAG3
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
@synthesize it_textfield;
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
    it_textfield.delegate=self;
    //创建一个UIDatePicker
    [self fn_create_datePick];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark create toolbar
-(UIToolbar*)fn_create_toolbar{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(fn_Click_done:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    return toolbar;
}
-(void)fn_Click_done:(id)sender{
    [self.tableView reloadData];
}
-(void)PopupView:(UIViewController*)VC Size:(CGSize) sheetSize{
    MZFormSheetController *formSheet=[[MZFormSheetController alloc]initWithViewController:VC];
    //弹出视图的大小
    formSheet.presentedFormSheetSize=sheetSize;
    formSheet.shadowRadius = 2.0;
    [formSheet setCornerRadius:0];
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
#pragma mark sent event
- (IBAction)fn_click_textfield:(id)sender{
    UITextField *btn=(UITextField*)sender;
    if (btn.tag==TAG1) {
        SearchPortNameViewController *VC=(SearchPortNameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchPortNameViewController"];
        VC.is_placeholder=@"Loading Port";
        VC.iobj_target=self;
        VC.isel_action=@selector(fn_show_portname:);
        [self PopupView:VC Size:CGSizeMake(320, 480)];
        
    }
    if (btn.tag==TAG3) {
       /* if (flag==0) {
            idp_picker.hidden=NO;
            flag=1;
        }else{
            idp_picker.hidden=YES;
            flag=0;
        }*/
        btn.inputView=idp_picker;
        
        UIToolbar *toolbar=[self fn_create_toolbar];
        btn.inputAccessoryView=toolbar;
    }
    if (btn.tag==TAG2) {
        SearchPortNameViewController *VC=(SearchPortNameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchPortNameViewController"];
        VC.iobj_target=self;
        VC.isel_action=@selector(fn_show_dis_portname:);
         VC.is_placeholder=@"Discharge Port";
        [self PopupView:VC Size:CGSizeMake(320, 480)];
        
    }
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
    [self.tableView reloadData];
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
    idp_picker=[[UIDatePicker alloc]init];
   // idp_picker.backgroundColor=[UIColor blueColor];
    [idp_picker setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    //设置UIDatePicker的显示模式
    [idp_picker setDatePickerMode:UIDatePickerModeDate];
    //当值发生改变的时候调用的方法
    [idp_picker addTarget:self action:@selector(fn_change_date) forControlEvents:UIControlEventValueChanged];
  
    
}
-(void)fn_change_date{
    //获得当前UIPickerDate所在的日期
    id_startdate=[idp_picker date];
    
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
            cell.ilb_show_portName.text=[idic_portname valueForKey:@"display"];
            cell.ilb_show_portName.tag=TAG1;
            if (idic_portname!=nil) {
                 [imd_searchDic setObject:[idic_portname valueForKey:@"data"] forKey:@"load_port"];
            }
            
        }
        if (indexPath.row==1) {
            cell.im_navigate_img.image=[UIImage imageNamed:@"navigate_down"];
            cell.ilb_port.text=@"Discharge Port";
            cell.ilb_show_portName.text=[idic_dis_portname valueForKey:@"display"];
            cell.ilb_show_portName.tag=TAG2;
            if (idic_dis_portname!=nil) {
                 [imd_searchDic setObject:[idic_dis_portname valueForKey:@"data"] forKey:@"dish_port"];
            }
           
        }
        cell.ilb_show_portName.delegate=self;
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
            cell.im_navigate_img.image=[UIImage imageNamed:@"calendar"];
            cell.ilb_port.text=@"Start Date";
            cell.ilb_show_portName.text=[self fn_DateToStringDate:id_startdate];
            cell.ilb_show_portName.tag=TAG3;
            [imd_searchDic setObject:cell.ilb_show_portName.text forKey:@"datefm"];
            cell.ilb_show_portName.delegate=self;
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
            cell.ict_show_days.delegate=self;
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
    if ([segue.identifier isEqualToString:@"segue_DetailSchedule"]) {
         DetailScheduleViewController *VC=[segue destinationViewController];
    VC.imd_searchDic=self.imd_searchDic;
    }
   
}
#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField*)textField{
    it_textfield = textField;//设置被点击的对象
    it_textfield.delegate=self;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [it_textfield  resignFirstResponder];
    return YES;
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
