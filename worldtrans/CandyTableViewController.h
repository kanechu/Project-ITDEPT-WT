//
//  CandyTableViewController.h
//  worldtrans
//
//  Created by itdept on 2/12/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong,nonatomic) NSArray *candyArray;
@property (strong,nonatomic) NSMutableArray *filteredCandyArray;
@property (strong,nonatomic) NSMutableArray *testArray;
@property (strong,nonatomic) NSMutableArray *filteredTestArray;

@property IBOutlet UISearchBar *candySearchBar;

@end
