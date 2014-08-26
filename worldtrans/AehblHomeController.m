//
//  AehblHomeController.m
//  worldtrans
//
//  Created by itdept on 14-3-13.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "AehblHomeController.h"
#import "AehblGeneralController.h"
#import "MilestoneController.h"
@interface AehblHomeController ()

@end

@implementation AehblHomeController

@synthesize segmentedControl;
@synthesize contentView;
@synthesize currentViewController;
@synthesize is_search_column;
@synthesize is_search_value;

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
    // add viewController so you can switch them later.
    UIViewController *vc = [self viewControllerForSegmentIndex:self.segmentedControl.selectedSegmentIndex];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    self.currentViewController = vc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    
    AehblGeneralController *vc;
    MilestoneController *a;
    switch (index) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AehblGeneralController"];
            vc.is_search_value = self.is_search_value;
            vc.is_search_column = self.is_search_column;
            return vc;
            break;
        case 1:
            a = [self.storyboard instantiateViewControllerWithIdentifier:@"MilestoneController"];
            if ([vc.is_search_column rangeOfString:@"so"].location>0) {
                a.is_docu_type = @"exso";
            } else {
                a.is_docu_type = @"aehbl";
            }
            a.is_docu_uid = self.is_search_value;
            return a;
            break;
    }
    return vc;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    [self addChildViewController:vc];
    [self transitionFromViewController:self.currentViewController toViewController:vc duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [self.currentViewController.view removeFromSuperview];
        self.contentView.frame=CGRectMake(0, 64,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
    } completion:^(BOOL finished) {
        [vc didMoveToParentViewController:self];
        [self.currentViewController removeFromParentViewController];
        self.currentViewController = vc;
    }];
    self.navigationItem.title = vc.title;
}

@end
