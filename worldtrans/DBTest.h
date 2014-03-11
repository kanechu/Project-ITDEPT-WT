//
//  DBManager.m
//  worldtrans
//
//  Created by itdept on 2/13/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBTest : NSObject
{
    NSString *databasePath;
}

+(DBTest*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
      department:(NSString*)department year:(NSString*)year;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;
-(NSMutableArray*) getData;

@end
