//
//  GuideViewController.m
//  worldtrans
//
//  Created by itdept on 14-5-28.
//  Copyright (c) 2014年 Worldtrans Logistics Services Ltd. . All rights reserved.
//

#import "GuideViewController.h"
#define PAGENUM 11

@interface GuideViewController ()

@end

@implementation GuideViewController

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
    [self fn_init_scrollView];
    //设置总页数，当前页
    _ip_pagecontroller.numberOfPages=PAGENUM;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//定义滚动视图的大小
-(void)fn_init_scrollView{
    _is_scrollview.contentSize=CGSizeMake(PAGENUM*self.view.frame.size.width, _is_scrollview.frame.size.height);
    _is_scrollview.pagingEnabled=YES;
    _is_scrollview.delegate=self;
    //为滚动视图添加子视图
    for (int i=0; i<PAGENUM; i++) {
        NSString *imageName=[NSString stringWithFormat:@"guide_%d",i+1];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*_is_scrollview.frame.size.width,0, _is_scrollview.frame.size.width, _is_scrollview.frame.size.height)];
        imageView.image=[UIImage imageNamed:imageName];
        [_is_scrollview addSubview:imageView];
        
    }
}

- (IBAction)fn_change_page:(id)sender {
    int page=_ip_pagecontroller.currentPage;
    [_is_scrollview setContentOffset:CGPointMake(self.view.frame.size.width*page, 0) animated:YES];
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth=_is_scrollview.frame.size.width;
    //计算当前页码
    int page=floor((_is_scrollview.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _ip_pagecontroller.currentPage=page;
    
}
@end
