//
//  AehblGeneralController.h
//  worldtrans
//
//  Created by itdept on 14-3-14.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AehblGeneralController : UITableViewController
@property(nonatomic) NSString *is_search_column;
@property(nonatomic) NSString *is_search_value;

@property (strong,nonatomic) NSMutableArray *ilist_aehbl;
@end
