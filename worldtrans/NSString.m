//
//  NSString.m
//  worldtrans
//
//  Created by itdept on 3/11/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "NSString.h"

@implementation NSString ( containsCategory )

- (BOOL) containsString: (NSString*) substring
{
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

@end