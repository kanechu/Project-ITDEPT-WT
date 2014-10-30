//
//  AehblListController.h
//  worldtrans
//
//  Created by itdept on 14-3-13.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AehblListController : UITableViewController<UISearchBarDelegate>

@property(nonatomic)NSString *is_search_no;

@property (weak, nonatomic) IBOutlet UISearchBar *iSearchBar;

@end
