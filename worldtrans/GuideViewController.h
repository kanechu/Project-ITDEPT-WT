//
//  GuideViewController.h
//  worldtrans
//
//  Created by itdept on 14-5-28.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *is_scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *ip_pagecontroller;
- (IBAction)fn_change_page:(id)sender;

@end
