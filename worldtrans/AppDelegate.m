//
//  AppDelegate.m
//  worldtrans
//
//  Created by itdept on 2/11/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>
#import "Web_get_alert.h"
#import "DB_login.h"
#import "DB_alert.h"

@implementation AppDelegate

@synthesize is_device_token;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    NSLog(@"Registering for push notifications...");
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge)];
    return YES;
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    is_device_token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    is_device_token = [is_device_token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Error %@",err);
    is_device_token = @"dev-ser";
    
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
        
        //background task here
        Web_get_alert *web_get_alert = [[Web_get_alert alloc] init];
        web_get_alert.iobj_target = self;
        web_get_alert.isel_action = @selector(fn_save_alert_list:);
        [web_get_alert fn_get_data];
    }
    else {
        // Push Notification received in the background
    }
}

- (void) fn_save_alert_list: (NSMutableArray *) alist_alert {
    DB_alert * ldb_alert = [[DB_alert alloc] init];
    [ldb_alert fn_save_data:alist_alert];
}

@end
