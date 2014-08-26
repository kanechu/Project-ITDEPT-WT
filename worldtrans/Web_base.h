//
//  Web_base.h
//  worldtrans
//
//  Created by itdept on 3/25/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "AppConstants.h"
#import "NSDictionary.h"
#import "NSArray.h"
@interface Web_base : NSObject

@property (strong,nonatomic) NSString *il_url;

@property (strong,nonatomic) Class iresp_class;

@property (strong,nonatomic) NSMutableArray *ilist_resp_result;

@property (strong,nonatomic) NSArray *ilist_resp_mapping;

@property (strong,nonatomic) id iobj_target;

@property (nonatomic, assign) SEL isel_action;

- (void) fn_get_data:(RequestContract*)ao_form ;

@end
