//
//  LoginViewController.m
//  worldtrans
//
//  Created by itdept on 14-3-18.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import "LoginViewController.h"
#import "TrackHomeController.h"
#import "MZFormSheetController.h"
#import <RestKit/RestKit.h>
#import "AuthContract.h"
#import "AppConstants.h"
#import "RequestContract.h"
#import "SearchFormContract.h"
#import "RespLogin.h"
#import "NSDictionary.h"
#import "DB_login.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginData;
@synthesize iobj_target;
@synthesize isel_action;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark getData method
- (void) fn_get_data: (NSString*)user_code :(NSString*)user_pass
{
    RequestContract *req_form = [[RequestContract alloc] init];
    
    req_form.Auth = [[AuthContract alloc] init];
    
    req_form.Auth.user_code = user_code;
    req_form.Auth.password = user_pass;
    req_form.Auth.system = @"ITNEW";
    
    
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
    // finished mapping
    NSString* path = STR_LOGIN_URL;
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:reqMapping
                                                                                   objectClass:[RequestContract class]
                                                                                   rootKeyPath:nil method:RKRequestMethodPOST];
    
    RKObjectMapping* respLoginMapping = [RKObjectMapping mappingForClass:[RespLogin class]];
    [respLoginMapping addAttributeMappingsFromArray:@[@"user_code",@"pass" ]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:respLoginMapping
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
                     RKLogInfo(@"Load collection of Articles: %@", result.array);
                    loginData = [NSDictionary dictionaryWithPropertiesOfObject:[result.array objectAtIndex: 0]];
                    
                    if ([[loginData valueForKey:@"pass"] isEqualToString:@"true"]) {
                        DB_login *dbLogin=[[DB_login alloc]init];
                        [dbLogin fn_save_data:_user_ID.text password:_user_Password.text];
                    
                       
                        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
                         [iobj_target performSelector:isel_action withObject:_user_ID.text];
                        
                    }else{
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您输入的用户名或密码不匹配" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancle", nil];
                        [alert show];
                    }
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    RKLogError(@"Operation failed with error: %@", error);
                }];
    
}


#pragma mark -userLogin method
- (IBAction)UserLogin:(id)sender {
    
    [self fn_get_data:_user_ID.text :_user_Password.text];


   
}

- (IBAction)closeLoginUI:(id)sender {
     [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController* formSheet){}];
}
@end
