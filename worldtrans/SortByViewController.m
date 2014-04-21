//
//  SortByViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-21.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "SortByViewController.h"
#import "MZFormSheetController.h"
#import "Cell_sortBy_list.h"
@interface SortByViewController ()

@end

@implementation SortByViewController
@synthesize imt_sort_list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imt_sort_list=@[@"Carrier",@"ETD",@"CY Cut",@"CFS Cut"];
    _ibt_cancel_btn.layer.cornerRadius=7;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fn_disappear_sortBy:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [imt_sort_list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifer=@"Cell_sortBy_list";
    Cell_sortBy_list *cell=[self.tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"Cell_sortBy_list" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
    }
    cell.ilb_sortby.text=[imt_sort_list objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"Cell_sortBy_header";
    UITableViewCell *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}
@end
