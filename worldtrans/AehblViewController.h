//
//  AehblViewController.h
//  worldtrans
//
//  Created by itdept on 2/22/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AehblViewController : UITableViewController<UISearchBarDelegate>

@property(nonatomic) NSString *is_search_no;

@property (strong,nonatomic) NSMutableArray *ilist_aehbl;

@property IBOutlet UISearchBar *iSearchBar;


@end
