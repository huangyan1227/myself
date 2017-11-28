//
//  HYMessageViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/3.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYMessageViewController.h"
#import "HYTitleButton.h"
#import "HYClickViewController.h"
@interface HYMessageViewController ()<HYTitleButtonDelegate>

@end

@implementation HYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
    //UIView *titleView =[[UIView alloc]init];
     // self.title =@"jiay";
    HYTitleButton *ViewButton =[[HYTitleButton alloc]init];
    ViewButton.frame=CGRectMake(0, 0, 200, 44);
    self.navigationItem.titleView = ViewButton;
    ViewButton.delegatehy =self;
}
-(void)hyTitleButton:(HYTitleButton *)titleButton dedSelectButtonIndex:(NSInteger)index{
    
  //  NSLog(@"aaaddd");
    if (index==0) {
        HYClickViewController *clickView =[HYClickViewController new];
       
        [self.navigationController pushViewController:clickView animated:YES];
       

    }else{
        
        
    }
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed =YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed=NO;
 
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
