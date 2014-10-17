//
//  MainHomeViewController.h
//  worldtrans
//
//  Created by itdept on 14-3-28.
//  Copyright (c) 2014年 itdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hdrImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) IBOutlet UICollectionView *iui_collectionview;

//点击ButtonItem触发事件的方法
- (IBAction)fn_menu_btn_clicked:(id)sender;

@end
