//
//  Web_get_alert.m
//  worldtrans
//
//  Created by itdept on 2/27/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "Web_get_alert.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespAlert.h"
#import "Cell_alert_list.h"
#import "Res_color.h"
#import "AppConstants.h"

@implementation Web_get_alert

@synthesize ilist_alert;
@synthesize isel_action;
@synthesize iobj_target;

- (void) fn_get_data:(NSString*)as_user_code withPwd: (NSString *)as_password;
{
    RequestContract *req_form = [[RequestContract alloc] init];
    
    req_form.Auth = [[AuthContract alloc] init];
    
    req_form.Auth.user_code = @"SA";
    req_form.Auth.password = @"SA1";
    req_form.Auth.system = @"ITNEW";
    
    SearchFormContract *search1 = [[SearchFormContract alloc]init];
    search1.os_column = @"device_id";
    search1.os_value = @"dev";
    
    
    
    SearchFormContract *search2 = [[SearchFormContract alloc]init];
    search2.os_column = @"request_sart_date";
    search2.os_value = @"2014-02-01";
    
    req_form.SearchForm = [NSSet setWithObjects:search1,search2, nil];
    
    RKObjectMapping *searchMapping = [RKObjectMapping requestMapping];
    [searchMapping addAttributeMappingsFromArray:@[@"os_column",@"os_value"]];
    
    
    RKObjectMapping *authMapping = [RKObjectMapping requestMapping];
    [authMapping addAttributeMappingsFromDictionary:@{ @"user_code": @"user_code",
                                                       @"password": @"password",
                                                       @"system": @"system" }];
    
    RKObjectMapping *reqMapping = [RKObjectMapping requestMapping];
    
    RKRelationshipMapping *searchRelationship = [RKRelationshipMapping
                                                 relationshipMappingFromKeyPath:@"SearchForm"
                                                 toKeyPath:@"SearchForm"
                                                 withMapping:searchMapping];
    
    
    RKRelationshipMapping *authRelationship = [RKRelationshipMapping
                                               relationshipMappingFromKeyPath:@"Auth"
                                               toKeyPath:@"Auth"
                                               withMapping:authMapping];
    
    [reqMapping addPropertyMapping:authRelationship];
    [reqMapping addPropertyMapping:searchRelationship];
    
    NSString* path = @"itleo.web/api/cargotracking/alert";
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:reqMapping
                                                                                   objectClass:[RequestContract class]
                                                                                   rootKeyPath:nil method:RKRequestMethodPOST];
    
    RKObjectMapping* respMilestoneMapping = [RKObjectMapping mappingForClass:[RespAlert class]];
    
    [respMilestoneMapping addAttributeMappingsFromArray:@[ @"ct_type",@"so_uid",@"hbl_uid",@"so_no",@"hbl_no",@"status_desc",@"act_status_date"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:respMilestoneMapping
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:STR_BASE_URL]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    [manager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    [manager postObject:req_form path:path parameters:nil
                success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                    // RKLogInfo(@"Load collection of Articles: %@", result.array);
                    //[self performSelector:action:ilist_alert];
                    ilist_alert = [NSMutableArray arrayWithArray:result.array];
                    
                    [iobj_target performSelector:isel_action withObject:ilist_alert];
                    
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    RKLogError(@"Operation failed with error: %@", error);
                }];
    
}
@end
