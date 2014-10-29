//
//  AppConstants.m
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AppConstants.h"

#ifdef DEBUG 
NSString* const STR_BASE_URL = @"http://223.255.167.158/itwebapi_v2";
NSString* const STR_LOGIN_URL=@"api/users/login";
NSString* const STR_SYPARA_URL=@"api/System/sypara";
NSString* const STR_MILESTONE_IMAGE_URL=@"api/CargoTracking/milestoneimage";
NSString* const STR_SEA_URL =@"api/cargotracking/exhbl";
NSString* const STR_AIR_URL =@"api/cargotracking/aehbl";
NSString* const STR_ALERT_URL=@"api/cargotracking/alert";
NSString* const STR_MILESTONE_URL=@"api/cargotracking/milestone";
NSString* const STR_SCHEDULE_URL=@"api/cargotracking/schedule";
NSString* const STR_PORTNAME_URL=@"api/master/maport";
NSString* const STR_SEARCHCRITERIA_URL=@"api/search/searchcriteria";
NSString* const STR_ICON_URL=@"api/system/icon";
NSString* const STR_EXCNTR_STATUS_URL=@"api/cargotracking/excntr_status";
#else
//worldtrans company
NSString* const STR_BASE_URL = @"http://223.255.167.158/itwebapi/";

//itdept company
NSString* const STR_BASE_URL = @"http://demo.itdept.com.hk/itleo.web/";

//kie
NSString* const STR_BASE_URL = @"http://192.168.1.17/kie_web_api/";

#endif