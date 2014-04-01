//
//  AppConstants.m
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AppConstants.h"

#ifdef DEBUG
NSString* const STR_BASE_URL = @"http://demo.itdept.com.hk/";
NSString* const STR_SEA_URL =@"itleo.web/api/cargotracking/exhbl";
NSString* const STR_AIR_URL =@"itleo.web/api/cargotracking/aehbl";
NSString* const STR_LOGIN_URL=@"itleo.web/api/users/login";
NSString* const STR_ALERT_URL=@"itleo.web/api/cargotracking/alert";
NSString* const STR_MILESTONE_URL=@"itleo.web/api/cargotracking/milestone";
#else
NSString* const STR_BASE_URL = @"http://demo.itdept.com.hk/";
NSString* const STR_SEA_URL =@"itleo.web/api/cargotracking/exhbl";
NSString* const STR_AIR_URL =@"itleo.web/api/cargotracking/aehbl";
NSString* const STR_LOGIN_URL=@"itleo.web/api/users/login";
NSString* const STR_ALERT_URL=@"itleo.web/api/cargotracking/alert";
NSString* const STR_MILESTONE_URL=@"itleo.web/api/cargotracking/milestone";
#endif
