//
//  ExhblViewController.h
//  worldtrans
//
//  Created by itdept on 2/12/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhblListController : UITableViewController <UISearchBarDelegate>

@property(nonatomic) NSString *is_search_no;

@property (strong,nonatomic) NSMutableArray *ilist_exhbl;

@property IBOutlet UISearchBar *iSearchBar;

@end
