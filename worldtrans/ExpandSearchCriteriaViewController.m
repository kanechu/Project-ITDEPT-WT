//
//  ExpandSearchCriteriaViewController.m
//  worldtrans
//
//  Created by itdept on 14-5-9.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "ExpandSearchCriteriaViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "DB_searchCriteria.h"
#import "Cell_schedule_section1.h"
#import "Cell_schedule_section2_row1.h"
#import "Cell_schedule_section2_row3.h"

#import "DetailScheduleViewController.h"
#import "SearchPortNameViewController.h"
#import "MZFormSheetController.h"
#import "PopViewManager.h"
@interface ExpandSearchCriteriaViewController ()

@end
enum TEXTFIELD_TAG {
    TAG1 = 1,
    TAG2 ,TAG3,TAG4,TAG5
};
static NSInteger day=0;

@implementation ExpandSearchCriteriaViewController
@synthesize checkText;
@synthesize ia_listData;
@synthesize ipic_drop_view;
@synthesize ilist_dateType;
@synthesize imd_searchDic;
@synthesize idp_picker;
@synthesize id_startdate;
@synthesize idic_portname;
@synthesize idic_dis_portname;
@synthesize select_row;
@synthesize section1_rows;
@synthesize section2_rows;
@synthesize alist_searchCriteria_section1;
@synthesize alist_searchCriteria_section2;
@synthesize flag_mandatory_key;
@synthesize imd_searchDic1;
@synthesize skstableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        //ios7的navigation不占位置，所以scollview自动空出一个nav的高度
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
            
            if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
                self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
       
    }
    return self;
}

-(void)fn_init_arrAnddic{
    imd_searchDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    imd_searchDic1=[[NSMutableDictionary alloc]initWithCapacity:10];
    alist_searchCriteria_section1=[[NSMutableArray alloc]initWithCapacity:10];
    alist_searchCriteria_section2=[[NSMutableArray alloc]initWithCapacity:10];
    ilist_dateType=[[NSMutableArray alloc]initWithCapacity:10];
    ia_listData=[[NSMutableArray alloc]initWithCapacity:10];
    flag_mandatory_key=[[NSMutableArray alloc]initWithCapacity:10];
}
-(void)fn_register_notifiction{
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 键盘高度变化通知，ios5.0新增的
    
#ifdef __IPHONE_5_0
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 5.0) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    
#endif
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.skstableView.SKSTableViewDelegate=self;
    [self fn_init_arrAnddic];
    section1_rows=0;
    section2_rows=0;
    
    //创建一个UIDatePicker
    [self fn_create_datePick];
    
    //创建一个UIPickerView
    [self fn_create_pickerView];
    [self fn_create_image];
    
    [self fn_get_searchCriteria_data];
    //注册通知
    [self fn_register_notifiction];
    //loadview的时候，打开所有expandable
    [self.skstableView fn_expandall];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//截取搜索标准的有用数据
-(void)fn_get_searchCriteria_data{
    DB_searchCriteria *db=[[DB_searchCriteria alloc]init];
    if ([db fn_get_all_data].count!=0) {
        _ibt_search_btn.hidden=NO;
    }
    for (NSMutableDictionary *dic in [db fn_get_all_data]) {
        //获取第一分区的行数和搜索标准数据
        if ([[dic valueForKey:@"group_name"] isEqualToString:@"LOCATION"]) {
            section1_rows++;
            [alist_searchCriteria_section1 addObject:dic];
        }
        //获取第二分区的行数和搜索标准数据
        if ([[dic valueForKey:@"group_name"] isEqualToString:@"Date"]) {
            section2_rows++;
            [alist_searchCriteria_section2 addObject:dic];
        }
        if ([[dic valueForKey:@"is_mandatory"] isEqualToString:@"1"]) {
            [flag_mandatory_key addObject:[dic valueForKey:@"col_label"]];
        }
        //获取date Range默认的天数
        if ([[dic valueForKey:@"col_type"] isEqualToString:@"int"]) {
            day=[[dic valueForKey:@"col_def"] integerValue];
        }
        //获取option 的数据
        if ([[dic valueForKey:@"col_type"] isEqualToString:@"combo"]) {
            NSString *str=[dic valueForKey:@"col_option"];
            //date type display
            NSArray *option=[str componentsSeparatedByString:@";"];
            NSArray *option1=nil;
            for (NSString *str in option) {
                option1=[str componentsSeparatedByString:@":"];
                if (option1.count>=2) {
                    //date type display
                    [ia_listData addObject:[option1 objectAtIndex:0]];
                    //value
                    [ilist_dateType addObject:[option1 objectAtIndex:1]];
                }
            }
        }
    }
}

-(void)fn_create_image{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(_ibt_search_btn.frame.origin.x+10, 5, 30, _ibt_search_btn.frame.size.height-10)];
    image.image=[UIImage imageNamed:@"search"];
    [_ibt_search_btn addSubview:image];
    
}
#pragma mark UItextfieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
     checkText = textField;//设置被点击的对象
}

#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification*)notification{
    if (nil == checkText) {
        
        return;
        
    }
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    //设置表视图frame
    [skstableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-keyboardRect.size.height-10)];
    //设置表视图可见cell
    [skstableView scrollToRowAtIndexPath:[NSIndexPath indexPathForSubRow:1 inRow:1 inSection:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

//键盘被隐藏的时候调用的方法
-(void)keyboardWillHide:(NSNotification*)notification {
    if (checkText) {
        //设置表视图frame,ios7的导航条加上状态栏是64
        [skstableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    }
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
    [self.skstableView reloadData];
}
#pragma mark pickerView
-(void)fn_create_pickerView{
    ipic_drop_view=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 225, 0,0)];
    [ipic_drop_view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    ipic_drop_view.delegate=self;
    //显示选中框
    ipic_drop_view.showsSelectionIndicator=YES;
    
    
}
#pragma mark UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [ia_listData count];
}
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [ia_listData objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    select_row=row;
    
}
#pragma mark sent event
- (IBAction)fn_click_portBtn:(id)sender{
    Custom_Button *Btn=(Custom_Button*)sender;
    PopViewManager *popV=[[PopViewManager alloc]init];
    if (Btn.tag==TAG1) {
        SearchPortNameViewController *VC=(SearchPortNameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchPortNameViewController"];
        VC.is_placeholder=@"Please fill in Load Port!";
        VC.iobj_target=self;
        VC.isel_action=@selector(fn_show_load_portname:);
        [popV PopupView:VC Size:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height) uponView:self];
        
    }
    if (Btn.tag==TAG2) {
        SearchPortNameViewController *VC=(SearchPortNameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SearchPortNameViewController"];
        VC.iobj_target=self;
        VC.isel_action=@selector(fn_show_dis_portname:);
        VC.is_placeholder=@"Please fill in Discharge Port!";
        [popV PopupView:VC Size:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height) uponView:self];
    }
}


- (IBAction)fn_click_subBtn:(id)sender {
    day--;
    if (day<0) {
        day=0;
    }
    [self.skstableView reloadData];
}

- (IBAction)fn_click_addBtn:(id)sender {
    day++;
    [self.skstableView reloadData];
}
//输入天数结束的时候(endEdit)，触发的方法
- (IBAction)fn_click_day:(id)sender {
    UITextField *textfield=(UITextField*)sender;
    if (textfield.tag==TAG5) {
        day=[textfield.text integerValue];
    }
    [self.skstableView reloadData];
}

- (IBAction)fn_begin_click_day:(id)sender {
    UITextField *textfield=(UITextField*)sender;
    if (textfield.tag==TAG5) {
        textfield.inputAccessoryView=[self fn_create_toolbar];
    }
}
//文本框beginEdit，触发的方法
- (IBAction)fn_click_textfield:(id)sender {
    UITextField *textfield=(UITextField*)sender;
    textfield.delegate=self;
    if (textfield.tag==TAG3) {
        textfield.inputView=ipic_drop_view;
        textfield.inputAccessoryView=[self fn_create_toolbar];
    }
    if (textfield.tag==TAG4) {
        textfield.inputView=idp_picker;
        textfield.inputAccessoryView=[self fn_create_toolbar];
    }
}

-(void)fn_show_load_portname:(NSMutableDictionary*)portname{
    idic_portname=portname;
    [self.skstableView reloadData];
}
-(void)fn_show_dis_portname:(NSMutableDictionary*)disportname{
    idic_dis_portname=disportname;
    [self.skstableView reloadData];
}

#pragma mark UIDatePick
-(void)fn_create_datePick{
    //初始化UIDatePicker
    idp_picker=[[UIDatePicker alloc]init];
    // idp_picker.backgroundColor=[UIColor blueColor];
    [idp_picker setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)];
    //设置UIDatePicker的显示模式
    [idp_picker setDatePickerMode:UIDatePickerModeDate];
    id_startdate=[idp_picker date];
    //当值发生改变的时候调用的方法
    [idp_picker addTarget:self action:@selector(fn_change_date) forControlEvents:UIControlEventValueChanged];
    
}
-(void)fn_change_date{
    //获得当前UIPickerDate所在的日期
    id_startdate=[idp_picker date];
    
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
        VC.imd_searchDic1=self.imd_searchDic1;
    }
    
}

#pragma mark 点击search按钮后，开始按条件获取数据
- (IBAction)fn_click_searchBtn:(id)sender {
    
    NSInteger flag=0;
    for (NSString *str in flag_mandatory_key) {
        if ([[imd_searchDic valueForKey:str] length]==0) {
            flag++;
            if (flag==1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@ cannot be empty!",str] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
            
        }
        
    }
    if (flag==0) {
        [self performSegueWithIdentifier:@"segue_DetailSchedule" sender:self];
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger flag=alist_searchCriteria_section1.count;
    NSInteger flag1=alist_searchCriteria_section2.count;
    if (flag!=0 && flag1!=0) {
        return 2;
    }else if (flag==0&&flag1==0){
        return 0;
    }else{
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return section1_rows;
    }
    if (indexPath.section==1) {
        return section2_rows;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //设置文本字体的颜色
    cell.textLabel.textColor=[UIColor colorWithRed:234.0/255.0 green:191.0/255.0 blue:229.0/255.0 alpha:1.0];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    if (indexPath.section==0) {
        cell.textLabel.text =[[alist_searchCriteria_section1 objectAtIndex:0]valueForKey:@"group_name"];
    }
    if (indexPath.section==1) {
        cell.textLabel.text=[[alist_searchCriteria_section2 objectAtIndex:0]valueForKey:@"group_name"];
    }
    cell.expandable = YES;
    
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
    static NSString *CellIdentifier = @"Cell_schedule_section11";
    Cell_schedule_section1 *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {
        cell=[[Cell_schedule_section1 alloc]init];
    }
        
    //提取分区1的数据
    NSMutableDictionary *dic=[alist_searchCriteria_section1 objectAtIndex:indexPath.subRow-1];
    if (indexPath.subRow==1) {
        cell.ilb_port.text=[dic valueForKey:@"col_label"];
        cell.ilb_show_portName.label.text=[idic_portname valueForKey:@"display"];
        cell.im_navigate_img.image=[UIImage imageNamed:@"navigate_up"];
        cell.ilb_show_portName.tag=TAG1;
        if (idic_portname!=nil) {
            [imd_searchDic setObject:[idic_portname valueForKey:@"data"] forKey:[flag_mandatory_key objectAtIndex:(indexPath.row+indexPath.section*2)]];
            [imd_searchDic setObject:[dic valueForKey:@"col_code"] forKey:@"load_port"];
            [imd_searchDic1 setObject:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)] forKey:@"1"];
        }
        
    }
    if (indexPath.subRow==2) {
        cell.im_navigate_img.image=[UIImage imageNamed:@"navigate_down"];
        cell.ilb_port.text=[dic valueForKey:@"col_label"];
        cell.ilb_show_portName.label.text=[idic_dis_portname valueForKey:@"display"];
        cell.ilb_show_portName.tag=TAG2;
        if (idic_dis_portname!=nil) {
            [imd_searchDic setObject:[idic_dis_portname valueForKey:@"data"] forKey:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)]];
            [imd_searchDic setObject:[dic valueForKey:@"col_code"] forKey:@"dish_port"];
            [imd_searchDic1 setObject:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)] forKey:@"2"];
        }
        
    }
    
    return cell;
}
    
    if (indexPath.section==1) {
        //提取分区2的数据
        NSMutableDictionary *dic1=[alist_searchCriteria_section2 objectAtIndex:indexPath.subRow-1];
        if (indexPath.subRow==1||indexPath.subRow==2) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row11";
            Cell_schedule_section2_row1 *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                cell=[[Cell_schedule_section2_row1 alloc]init];
            }
            if (indexPath.subRow==1) {
                cell.ilb_show_dateAndtype.text=[dic1 valueForKey:@"col_label"];
                cell.itf_show_dateType.text=[ia_listData objectAtIndex:select_row];
                ;
                cell.itf_show_dateType.tag=TAG3;
                
                if (ilist_dateType!=nil) {
                    [imd_searchDic setObject: [ilist_dateType objectAtIndex:select_row] forKey:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)]];
                    [imd_searchDic setObject:[dic1 valueForKey:@"col_code"] forKey:@"datetype"];
                    [imd_searchDic1 setObject:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)] forKey:@"3"];
                }
            }
            
            if (indexPath.subRow==2) {
                
                cell.ilb_show_dateAndtype.text=[[alist_searchCriteria_section2 objectAtIndex:indexPath.subRow-1]valueForKey:@"col_label"];            cell.ii_calendar_img.image=[UIImage imageNamed:@"calendar"];
                
                cell.ilb_show_dateAndtype.text=@"Start Date";
                cell.itf_show_dateType.text=[self fn_DateToStringDate:id_startdate];
                cell.itf_show_dateType.tag=TAG4;
                
                [imd_searchDic setObject:cell.itf_show_dateType.text forKey:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)]];
                [imd_searchDic setObject:[dic1 valueForKey:@"col_code"] forKey:@"datefm"];
                [imd_searchDic1 setObject:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)] forKey:@"4"];
            }
            
            return cell;
        }
        
        if (indexPath.subRow==3) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row31";
            Cell_schedule_section2_row3 *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                cell=[[Cell_schedule_section2_row3 alloc]init];
            }
            if ([self fn_DateToStringDate:id_startdate].length!=0 && day!=0) {
                [imd_searchDic setObject:[self fn_get_finishDate:day] forKey:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)]];
                
            }else if([self fn_DateToStringDate:id_startdate].length!=0 && day==0){
                [imd_searchDic setObject:[self fn_DateToStringDate:id_startdate] forKey:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)]];
            }
            [imd_searchDic setObject:[dic1 valueForKey:@"col_code"] forKey:@"dateto"];
            [imd_searchDic1 setObject:[flag_mandatory_key objectAtIndex:(indexPath.subRow-1+indexPath.section*2)] forKey:@"5"];
            cell.ict_show_days.tag=TAG5;
            cell.ict_show_days.text=[NSString stringWithFormat:@"%d",day];
            cell.ict_show_days.delegate=self;
            
            return cell;
        }
    }
    // Configure the cell...
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
