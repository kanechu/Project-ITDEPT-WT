//
//  ExhblHomeController.h
//  worldtrans
//
//  Created by itdept on 2/24/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhblHomeController : UIViewController

@property (nonatomic, strong) UIViewController *currentViewController;

@property(nonatomic) NSString *is_search_column;
@property(nonatomic) NSString *is_search_value;

@property (nonatomic,weak) IBOutlet UIView *contentView;

@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentChanged:(UISegmentedControl *)sender;

@end


