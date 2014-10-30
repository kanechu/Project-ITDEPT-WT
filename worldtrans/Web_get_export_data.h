//
//  Web_get_export_data.h
//  worldtrans
//
//  Created by itdept on 14-10-30.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;
typedef void (^callBack_result)(NSMutableArray *alist_result);

@interface Web_get_export_data : NSObject

@property(nonatomic,strong)callBack_result callBack;

@property(nonatomic,strong)MBProgressHUD *hud_obj;
@property(nonatomic,strong)UIViewController *VC;
- (void) fn_get_data: (NSString*)as_search_no;
@end
