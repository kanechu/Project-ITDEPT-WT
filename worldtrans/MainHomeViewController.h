//
//  MainHomeViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-28.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollerView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hdrImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;
@property (strong,nonatomic) NSMutableArray *ilist_menu;
@property (nonatomic, retain) IBOutlet UICollectionView *iui_collectionview;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(assign,nonatomic)CGRect alertFram;

- (void) fn_save_alert_list: (NSMutableArray *) alist_alert;
@end
