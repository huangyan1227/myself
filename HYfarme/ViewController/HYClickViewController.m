//
//  HYClickViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/3.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYClickViewController.h"

@interface HYClickViewController ()
@property(nonatomic,strong) UIImageView * imageView;
@end
#define FPS 30.0
@implementation HYClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor orangeColor];
    
    UIBarButtonItem *butonItem =[[UIBarButtonItem alloc]initWithTitle:@"加油" style: UIBarButtonItemStylePlain target:self action:@selector(click)];
    
    UIButton * animation = [[UIButton alloc]init];
    
    animation.frame = CGRectMake(20, 40, 150, 80);
    
    [animation setTitle:@"动画" forState:UIControlStateNormal];
    
    [animation setTintColor:[UIColor blackColor]];
    
    [animation addTarget:self action:@selector(addanimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:animation];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    
    imageView.frame = CGRectMake(20, 150, 200, 200);
    
    imageView.image = [UIImage imageNamed:@"default_avatar"];
    
    self.imageView = imageView;
    
    [self.view addSubview:imageView];

    self.navigationItem.leftBarButtonItem=butonItem;
    
    //self.tabBarController.hidesBottomBarWhenPushed =NO;
}
-(void)addanimation{
    
    NSLog(@"ggg");
    //转场动画
    [UIView transitionWithView:self.imageView duration:2.0 options:  UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.imageView.image = [UIImage imageNamed:@"user_defaultgift"];
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"ghjjkl;kk");
            [UIView transitionWithView:self.imageView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                
                self.imageView.image = [UIImage imageNamed:@"default_avatar"];
            } completion:nil];
        });
        
    }];
    
    
    UIImageView * imageView = [[UIImageView alloc]init];
    
    
     [self.view addSubview:imageView];
    imageView.frame = CGRectMake(20, 350, 100, 100);
    
   // imageView.backgroundColor = [UIColor yellowColor];
    
    imageView.image = [UIImage animatedImageNamed:@"loading_" duration:6.0/FPS];
    
   
    

    
    
}
-(void)click{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
 
}


@end
