//
//  AppDelegate.h
//  worldtrans
//
//  Created by itdept on 2/11/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    Reachability *hostReach;
}

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic) NSString *is_device_token;

@end
