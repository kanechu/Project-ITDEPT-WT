//
//  MainHomeViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-28.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Menu_home;
@interface MainHomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hdrImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) NSMutableArray *ilist_menu;
@property (nonatomic, retain) IBOutlet UICollectionView *iui_collectionview;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (assign,nonatomic)NSInteger badge_Num;
@property (nonatomic,weak)Menu_home *menu_item;

- (void) fn_save_alert_list: (NSMutableArray *) alist_alert;
//点击ButtonItem触发事件的方法
- (IBAction)ClickButonItem:(id)sender;

@end
