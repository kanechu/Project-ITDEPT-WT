//
//  CheckScheduleViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-18.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "CheckScheduleViewController.h"
#import "Cell_schedule_section1.h"
#import "Cell_schedule_section2_row1.h"
#import "Cell_schedule_section2_row3.h"
@interface CheckScheduleViewController ()

@end

@implementation CheckScheduleViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return 3;
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
            cell.ilb_port.text=@"Discharge Port";
        }
        if (indexPath.row==1) {
            [cell.ibt_navigate_btn setImage:[UIImage imageNamed:@"navigate_down"] forState:UIControlStateNormal];
            cell.ilb_port.text=@"Loading Port";
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
            cell.ilb_port.text=@"Start Date";
            return cell;
        }
        if (indexPath.row==2) {
            static NSString *CellIdentifier = @"Cell_schedule_section2_row3";
            Cell_schedule_section2_row3 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_schedule_section2_row3" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            return cell;
        }
    }
    
    // Configure the cell...
    
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
