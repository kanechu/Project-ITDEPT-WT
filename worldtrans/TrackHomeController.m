//
//  FirstViewController.m
//  worldtrans
//
//  Created by itdept on 2/11/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "TrackHomeController.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespExhbl.h"

@interface TrackHomeController ()


@end

@implementation TrackHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    ReqExhblContract *req_form = [[ReqExhblContract alloc] init];
    
    req_form.Auth = [[AuthContract alloc] init];
    
    req_form.Auth.user_code = @"SA";
    req_form.Auth.password = @"SA1";
    req_form.Auth.system = @"ITNEW";
    
    SearchFormContract *search = [[SearchFormContract alloc]init];
    search.os_column = @"search_no";
    search.os_value = @"999";

    req_form.SearchForm = [NSSet setWithObjects:search, nil];
    
    
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
    
    NSString* path = @"itleo.web/api/cargotracking/exhbl";
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:reqMapping
                     objectClass:[ReqExhblContract class]
                     rootKeyPath:nil method:RKRequestMethodPOST];
    
    RKObjectMapping* respExhblMapping = [RKObjectMapping mappingForClass:[RespExhbl class]];
    [respExhblMapping addAttributeMappingsFromArray:@[ @"ct_type", @"so_uid", @"hbl_uid", @"so_no", @"hbl_no", @"cbl_no"
                                                       , @"shpr_name", @"cnee_name", @"agent_name", @"load_port", @"dest_name", @"dish_port", @"vsl_voy", @"etd", @"eta", @"eta_dest"
                                                       , @"prt_onboard_date", @"ship_pkg", @"ship_kgs", @"ship_cbm", @"ship_unit", @"prt_tran_inter_port", @"feeder_vsl_voy", @"feeder_etd", @"no_of_cntr_1"
                                                       , @"no_of_cntr_2", @"no_of_cntr_3", @"no_of_cntr_4", @"place_of_receipt", @"delivery_name", @"status_desc", @"act_status_date"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:respExhblMapping
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://demo.itdept.com.hk"]];
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    [manager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    [manager postObject:req_form path:path parameters:nil
                success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
                    RKLogInfo(@"Load collection of Articles: %@", result.array);
                    
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    RKLogError(@"Operation failed with error: %@", error);
                }];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        ExhblListController *controller = (ExhblListController *)segue.destinationViewController;
    }
    
    if([segue.identifier isEqualToString:@"segue_exhbl"]){
        ExhblListController *controller = (ExhblListController *)segue.destinationViewController;
       controller.is_search_no = @"999";
    }
}


@end
