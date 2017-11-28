//
//  HYSeacherViewController.m
//  HYfarme
//
//  Created by bidiao on 16/1/27.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "HYSeacherViewController.h"
#import "SXMarquee.h"
#import "UIColor+Wonderful.h"
@interface HYSeacherViewController ()

@end

@implementation HYSeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
   
   
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSLog(@"dfsfsa");
    SXMarquee *mag =[[SXMarquee alloc]initWithFrame:CGRectMake(20, 80, 400, 80) speed:50.0 Msg:@"jia"];
    mag.backgroundColor =[UIColor redColor];
    [mag changeMarqueeLabelFont:[UIFont systemFontOfSize:13.0]];
    [mag start];
    
    [self.view addSubview:mag];
    
    SXMarquee * mag1 =[[SXMarquee alloc]initWithFrame:CGRectMake(0, 200, 300, 90) speed:5 Msg:@"和重点是Joe" bgColor:[UIColor lightBLue] txtColor:[UIColor redColor]];
    [mag1 start];
    [self.view addSubview:mag1];

    
    
    
}
-(void)sxmarquee{
//    SXMarquee * mag = [[SXMarquee alloc]initWithFrame:CGRectMake(10, 70, 250, 90) speed:50 Msg:@"sb曹" bgColor:[UIColor goldColor] txtColor:[UIColor redColor]];
//    
//    [mag start];
//    [self.view addSubview:mag];
//    
//    SXMarquee *mag1 =[[SXMarquee alloc]initWithFrame:CGRectMake(0, 180, 300, 80) speed:5.0 Msg:@"jia"];
//        mag1.backgroundColor =[UIColor redColor];
//    
//        [mag1 start];
//    
//        [self.view addSubview:mag1];
//    
    
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
