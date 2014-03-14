//
//  AehblHomeController.h
//  worldtrans
//
//  Created by itdept on 14-3-13.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AehblHomeController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) UIViewController *currentViewController;


@property(nonatomic) NSString *is_search_column;
@property(nonatomic) NSString *is_search_value;

- (IBAction)segmentChanged:(UISegmentedControl *)sender;
@end
