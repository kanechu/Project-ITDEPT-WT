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
#import "DB_icon.h"
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
@synthesize skstableView;
@synthesize db;
@synthesize alist_searchCriteria;
@synthesize alist_groupNameAndNum;
@synthesize alist_filtered_data;
@synthesize alist_icon;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fn_init_global_Variable];
    [self fn_sort_criteriaData];
    self.skstableView.SKSTableViewDelegate=self;
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
    
    [self setExtraCellLineHidden:skstableView];
   	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 对数组进行排序
-(void)fn_sort_criteriaData{
    //如果需要降序，那么将ascending由YES改为NO
    NSSortDescriptor *sortByName1=[NSSortDescriptor sortDescriptorWithKey:@"seq" ascending:YES];
    
    NSArray *sortDescriptors=[NSArray arrayWithObjects:sortByName1,nil];
    NSMutableArray *sortedArray=[[alist_searchCriteria sortedArrayUsingDescriptors:sortDescriptors]mutableCopy];
    //重新排序后，存回给原来的数组
    alist_searchCriteria=sortedArray;
}
#pragma mark 对数组进行过滤
-(NSArray*)fn_filtered_criteriaData:(NSString*)key{
    NSArray *filtered=[alist_searchCriteria filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(group_name==%@)",key]];
    return filtered;
}

-(void)fn_init_global_Variable{
    db=[[DB_searchCriteria alloc]init];
    alist_searchCriteria=[db fn_get_all_data];
    DB_icon *db_icon=[[DB_icon alloc]init];
    alist_icon=[db_icon fn_get_all_iconData];
    imd_searchDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    ilist_dateType=[[NSMutableArray alloc]initWithCapacity:10];
    ia_listData=[[NSMutableArray alloc]initWithCapacity:10];
    alist_filtered_data=[[NSMutableArray alloc]initWithCapacity:10];
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

//将额外的cell的线隐藏
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
//截取搜索标准的有用数据
-(void)fn_get_searchCriteria_data{
   
    if ([db fn_get_all_data].count!=0) {
        _ibt_search_btn.hidden=NO;
    }
    alist_groupNameAndNum=[db fn_get_groupNameAndNum];
    
    for (NSMutableDictionary *dic in [db fn_get_all_data]) {
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
    }
    
}

#pragma mark 点击search按钮后，开始按条件获取数据
- (IBAction)fn_click_searchBtn:(id)sender {
    
    NSInteger flag=0;
    for (NSMutableDictionary *dic in alist_searchCriteria) {
        if ([dic valueForKey:@"is_mandatory"]) {
            if ([[dic valueForKey:@"col_type"] isEqualToString:@"LOOKUP"] && [[imd_searchDic valueForKey:@"load_port_value"] length]==0) {
                flag++;
            }
            if ([[dic valueForKey:@"col_type"] isEqualToString:@"lookup"] && [[imd_searchDic valueForKey:@"dish_port_value"] length]==0) {
                flag++;
            }
            if (flag==1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@ cannot be empty!",[dic valueForKey:@"col_label"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                break;
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
    return [alist_groupNameAndNum count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *numOfrow=[[alist_groupNameAndNum objectAtIndex:indexPath.section] valueForKey:@"COUNT(group_name)"];
    return [numOfrow integerValue];
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
    cell.textLabel.text =[[alist_groupNameAndNum objectAtIndex:indexPath.section] valueForKey:@"group_name"];
    
    NSString *str=[[alist_groupNameAndNum objectAtIndex:indexPath.section] valueForKey:@"group_name"];
    NSArray *arr=[self fn_filtered_criteriaData:str];
    if (arr!=nil) {
         [alist_filtered_data addObject:arr];
    }
    cell.expandable = YES;
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    //提取每行的数据
    NSMutableDictionary *dic=alist_filtered_data[indexPath.section][indexPath.subRow-1];
    //显示的提示名称
    NSString *col_label=[dic valueForKey:@"col_label"];
    //传上服务器的volumn
    NSString *col_code=[dic valueForKey:@"col_code"];
    //类型，用于判断使用的cell
    NSString *col_type=[dic valueForKey:@"col_type"];
    if ([col_type isEqualToString:@"LOOKUP"] || [col_type isEqualToString:@"lookup"]) {
        
        static NSString *CellIdentifier = @"Cell_schedule_section11";
        Cell_schedule_section1 *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell==nil) {
            cell=[[Cell_schedule_section1 alloc]init];
        }
        if ([col_type isEqualToString:@"LOOKUP"]) {
            cell.ilb_port.text=col_label;
            cell.ilb_show_portName.label.text=[idic_portname valueForKey:@"display"];
            cell.im_navigate_img.image=[UIImage imageWithData:[self fn_get_imageData:@"crmsubregion"]];
            cell.ilb_show_portName.tag=TAG1;
            if (idic_portname!=nil) {
                [imd_searchDic setObject:[idic_portname valueForKey:@"data"] forKey:@"load_port_value"];
                [imd_searchDic setObject:col_code forKey:@"load_port_column"];
            }
            
        }
        if ([col_type isEqualToString:@"lookup"]) {
            cell.im_navigate_img.image=[UIImage imageWithData:[self fn_get_imageData:@"crmsubregion"]];
            cell.ilb_port.text=col_label;
            cell.ilb_show_portName.label.text=[idic_dis_portname valueForKey:@"display"];
            cell.ilb_show_portName.tag=TAG2;
            if (idic_dis_portname!=nil) {
                [imd_searchDic setObject:[idic_dis_portname valueForKey:@"data"] forKey:@"dish_port_value"];
                [imd_searchDic setObject:col_code forKey:@"dish_port_column"];
            }
            
        }
        
        return cell;
    }
    
    if ([col_type isEqualToString:@"combo"] || [col_type isEqualToString:@"date"]){
        static NSString *CellIdentifier = @"Cell_schedule_section2_row11";
        Cell_schedule_section2_row1 *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell==nil) {
            cell=[[Cell_schedule_section2_row1 alloc]init];
        }
        if ([col_type isEqualToString:@"combo"]) {
            cell.ilb_show_dateAndtype.text=col_label;
            cell.itf_show_dateType.text=[ia_listData objectAtIndex:select_row];
            ;
            cell.itf_show_dateType.tag=TAG3;
            cell.ii_calendar_img.image=[UIImage imageWithData:[self fn_get_imageData:@"crmacct"]];
            if (ilist_dateType!=nil) {
                [imd_searchDic setObject:col_code forKey:@"datetype_column"];
                [imd_searchDic setObject:[ilist_dateType objectAtIndex:select_row]forKey:@"datetype_value"];
            }
        }
        
        if ([col_type isEqualToString:@"date"]) {
            
            cell.ilb_show_dateAndtype.text=col_label;
            cell.ii_calendar_img.image=[UIImage imageWithData:[self fn_get_imageData:@"crmregion"]];
            cell.itf_show_dateType.text=[self fn_DateToStringDate:id_startdate];
            cell.itf_show_dateType.tag=TAG4;
            [imd_searchDic setObject:col_code forKey:@"datefm_column"];
            [imd_searchDic setObject: cell.itf_show_dateType.text forKey:@"datefm_value"];
        }
        
        return cell;
    }
    if ([col_type isEqualToString:@"int"]) {
        static NSString *CellIdentifier = @"Cell_schedule_section2_row31";
        Cell_schedule_section2_row3 *cell = [self.skstableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (cell==nil) {
            cell=[[Cell_schedule_section2_row3 alloc]init];
        }
        if ([self fn_DateToStringDate:id_startdate].length!=0 && day!=0) {
           
            [imd_searchDic setObject:[self fn_get_finishDate:day]forKey:@"dateto_value"];
            
        }else if([self fn_DateToStringDate:id_startdate].length!=0 && day==0){
            
            [imd_searchDic setObject:[self fn_DateToStringDate:id_startdate] forKey:@"dateto_value"];
        }
        [imd_searchDic setObject:col_code forKey:@"dateto_column"];
        cell.ict_show_days.tag=TAG5;
        cell.ict_show_days.text=@(day).stringValue;
        cell.ict_show_days.delegate=self;
        [cell.ibt_add_btn setImage:[UIImage imageWithData:[self fn_get_imageData:@"int_minus"]] forState:UIControlStateNormal];
        [cell.ibt_decrease_btn setImage:[UIImage imageWithData:[self fn_get_imageData:@"int_add"]] forState:UIControlStateNormal];
        cell.ii_calendar_img.image=[UIImage imageWithData:[self fn_get_imageData:@"date"]];
        return cell;
    }
      // Configure the cell...
    return nil;
}
#pragma mark 遍历数组
-(NSData*)fn_get_imageData:(NSString*)str{
    for (NSMutableDictionary *dic in alist_icon) {
        if ([[dic valueForKey:@"ic_name"] isEqualToString:str]) {
            NSString *icon=[dic valueForKey:@"ic_content"];
            NSData *data=[[NSData alloc]initWithBase64EncodedString:icon options:0];
            return data;
        }
    }
    return nil;
}
-(NSMutableDictionary*)fn_get_DataOfRow:(NSString*)str{
    for (NSMutableDictionary *dic in alist_filtered_data) {
        if ([[dic valueForKey:@"col_type"] isEqualToString:str]) {
            return dic;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
