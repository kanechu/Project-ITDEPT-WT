//
//  AppConstants.h
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
#define DEFAULT_USERCODE @"ANONYMOUS"
#define DEFAULT_PASS @"ANONYMOUS1"
#define DEFAULT_SYSTEM @"ITTRACK_WTRAN"
@interface AppConstants : NSObject

extern NSString* const STR_BASE_URL;
extern NSString* const STR_LOGIN_URL;
extern NSString* const STR_SYPARA_URL;
extern NSString* const STR_SEA_URL;
extern NSString* const STR_AIR_URL;
extern NSString* const STR_ALERT_URL;
extern NSString* const STR_MILESTONE_URL;
extern NSString* const STR_SCHEDULE_URL;
extern NSString* const STR_PORTNAME_URL;
extern NSString* const STR_SEARCHCRITERIA_URL;
extern NSString* const STR_ICON_URL;
@end
