//
//  FirstViewController.m
//  worldtrans
//
//  Created by itdept on 2/11/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//

#import "TrackHomeController.h"

@interface TrackHomeController ()


@end

@implementation TrackHomeController
-(void)initBackgroundColor{
    [self.view setBackgroundColor:[UIColor blackColor]];
}
//给按钮添加边框的方法
-(void)addBound:(UIButton*)_sender{
   

    [_sender.layer setMasksToBounds:YES];
    [_sender.layer setContentsScale:22];
    [_sender.layer setCornerRadius:2.0];
    [_sender.layer setBorderWidth:1.0];
    
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
   
    //前三位是RGB 0,0,255
    CGColorRef colorRef=CGColorCreate(colorSpace, (CGFloat[]){0,0,255,2});
    
    [_sender.layer setBorderColor:colorRef];

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _ltf_search_no.delegate=self;
    [self addBound:_lbtn_exhbl_search];
    [self addBound:_lbtn_exhbl_AirSearch];
    [self initBackgroundColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segue_aehbl"]){
        AehblListController *controller = (AehblListController *)segue.destinationViewController;
         controller.is_search_no =_ltf_search_no.text;
    }
    
    if([segue.identifier isEqualToString:@"segue_exhbl"]){
        ExhblListController *controller = (ExhblListController *)segue.destinationViewController;
        controller.is_search_no =_ltf_search_no.text;
    }
   
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_ltf_search_no resignFirstResponder];
    return YES;
}


@end
