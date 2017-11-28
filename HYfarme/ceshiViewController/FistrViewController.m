//
//  FistrViewController.m
//  HYfarme
//
//  Created by bidiao on 16/1/25.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "FistrViewController.h"
#import "SecondViewController.h"
@interface FistrViewController ()

@end

@implementation FistrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(click)];
   
    self.navigationItem.rightBarButtonItem = item;
    UIButton * button =[[UIButton alloc]initWithFrame:CGRectMake(10, 100, 200, 100)];
    [button setTitle:@"我是" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)clickview{
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(100, 300, 200, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    
    
}
-(void)click{
    
    
    NSLog(@"第二个");
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
