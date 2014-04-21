//
//  DetailScheduleViewController.m
//  worldtrans
//
//  Created by itdept on 14-4-19.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "DetailScheduleViewController.h"
#import "MZFormSheetController.h"
#import "SortByViewController.h"
@interface DetailScheduleViewController ()

@end

@implementation DetailScheduleViewController

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
    _fn_click_sortBy_btn.style=UIBarButtonSystemItemCamera;
    //searchBar的代理
    _is_seach_bar.delegate=self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark popView
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

- (IBAction)fn_click_sortBy_btn:(id)sender {
    SortByViewController *sortByVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SortByViewController"];
    [self PopupView:sortByVC Size:CGSizeMake(250, 300)];
}

#pragma mark UISearchBarDelegate
//点击搜索按钮的cancel，键盘收起
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [_is_seach_bar resignFirstResponder];
}
//点击搜索的时候，触发的事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
@end
