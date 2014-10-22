//
//  AppConstants.m
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AppConstants.h"

#ifdef DEBUG 
NSString* const STR_BASE_URL = @"http://192.168.1.17/";
NSString* const STR_LOGIN_URL=@"kie_web_api/api/users/login";
NSString* const STR_SYPARA_URL=@"/kie_web_api/api/System/sypara";
NSString* const STR_MILESTONE_IMAGE_URL=@"kie_web_api/api/CargoTracking/milestoneimage";
NSString* const STR_SEA_URL =@"kie_web_api/api/cargotracking/exhbl";
NSString* const STR_AIR_URL =@"kie_web_api/api/cargotracking/aehbl";
NSString* const STR_ALERT_URL=@"kie_web_api/api/cargotracking/alert";
NSString* const STR_MILESTONE_URL=@"kie_web_api/api/cargotracking/milestone";
NSString* const STR_SCHEDULE_URL=@"kie_web_api/api/cargotracking/schedule";
NSString* const STR_PORTNAME_URL=@"kie_web_api/api/master/maport";
NSString* const STR_SEARCHCRITERIA_URL=@"kie_web_api/api/search/searchcriteria";
NSString* const STR_ICON_URL=@"kie_web_api/api/system/icon";
NSString* const STR_EXCNTR_STATUS_URL=@"kie_web_api/api/cargotracking/excntr_status";
#else
//worldtrans company
NSString* const STR_BASE_URL = @"http://223.255.167.158/";
NSString* const STR_SEA_URL =@"itwebapi/api/cargotracking/exhbl";
NSString* const STR_AIR_URL =@"itwebapi/api/cargotracking/aehbl";
NSString* const STR_LOGIN_URL=@"itwebapi/api/users/login";
NSString* const STR_ALERT_URL=@"itwebapi/api/cargotracking/alert";
NSString* const STR_MILESTONE_URL=@"itwebapi/api/cargotracking/milestone";
NSString* const STR_SCHEDULE_URL=@"itwebapi/api/cargotracking/schedule";
NSString* const STR_PORTNAME_URL=@"itwebapi/api/master/maport";
NSString* const STR_SEARCHCRITERIA_URL=@"itwebapi/api/search/searchcriteria";
NSString* const STR_ICON_URL=@"itwebapi/api/system/icon";

//itdept company
NSString* const STR_BASE_URL = @"http://demo.itdept.com.hk/";
NSString* const STR_LOGIN_URL=@"itleo.web/api/users/login";
NSString* const STR_SYPARA_URL=@"itleo.web/api/System/sypara";
NSString* const STR_SEA_URL =@"itleo.web/api/cargotracking/exhbl";
NSString* const STR_AIR_URL =@"itleo.web/api/cargotracking/aehbl";
NSString* const STR_ALERT_URL=@"itleo.web/api/cargotracking/alert";
NSString* const STR_MILESTONE_URL=@"itleo.web/api/cargotracking/milestone";
NSString* const STR_SCHEDULE_URL=@"itleo.web/api/cargotracking/schedule";
NSString* const STR_PORTNAME_URL=@"itleo.web/api/master/maport";
NSString* const STR_SEARCHCRITERIA_URL=@"itleo.web/api/search/searchcriteria";
NSString* const STR_ICON_URL=@"itleo.web/api/system/icon";

#endif