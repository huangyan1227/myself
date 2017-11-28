//
//  HYNavigationViewController.m
//  HYfarme
//
//  Created by bidiao on 16/1/25.
//  Copyright © 2016年 bidiao. All rights reserved.
//手势

#import "HYNavigationViewController.h"

@interface HYNavigationViewController ()
/**
 *  存放截图的
 */
@property(nonatomic,strong) NSMutableArray * images;
@property(nonatomic,strong) UIImageView * lastVcView;
@property(nonatomic,strong) UIView * cover;


@end

@implementation HYNavigationViewController
-(NSMutableArray *)images{
    if (!_images) {
        _images=[NSMutableArray array];
    }
    
    return _images;
    
}
-(UIImageView *)lastVcView {
    if (!_lastVcView) {
        UIWindow * window =[UIApplication sharedApplication].keyWindow;
        UIImageView * lastVcView =[[UIImageView alloc]init];
        lastVcView.frame = window.bounds;
        self.lastVcView = lastVcView;
        
    }
    
    return _lastVcView;
    
}
/**
 *  覆盖
 *
 *  @return UIView
 */
-(UIView *)cover {
    if (!_cover) {
        UIWindow * window =[UIApplication sharedApplication].keyWindow;
        UIView *coverView =[[UIView alloc]init];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.frame = window.bounds;
        coverView.alpha = 0.5;
        self.cover = coverView;
    }
    
    return _cover;
    
}
+(void)initialize{
    
//    UINavigationBar* nappenace =[UINavigationBar appearance];
//    
//   [nappenace setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer * recognizer =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(draming:)];
    [self.view addGestureRecognizer:recognizer];
  NSLog(@"第一个dddddfdf");
    
    
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}
/**
 *  截图
 */
-(void)createScreenShort{
  
    UIGraphicsBeginImageContextWithOptions( self.view.frame.size , YES, 0.0);
   // [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image =UIGraphicsGetImageFromCurrentImageContext();
    
    [self.images addObject:image];
    UIGraphicsEndImageContext();
   // UIImage *img=[UIImage mage];
   // NSLog(@"%@",self.images);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   //  NSLog(@"谁NavigationView");
    //if (self.images.count > 0) return;
    //NSLog(@"NavigationView");
    [self createScreenShort];
  
}

-(void)draming:(UIPanGestureRecognizer *)recognizer{
    NSLog(@"移动");
    CGPoint poing =[recognizer translationInView:self.view];
    NSLog(@"FFFFFFFFFFF%@",NSStringFromCGPoint(poing) );
   // if (self.viewControllers.count <=1) return;
    CGFloat tx = [recognizer translationInView:self.view].x;
    
    NSLog(@" 3  %f",tx);
     // if(tx< 0)return;
    //gr.state==UIGestureRecognizerStateEnded||gr.state==UIGestureRecognizerStateCancelled
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        
      //  UIWindow * windo =[UIApplication sharedApplication].keyWindow;
        
        //UIView * view =    [windo.subviews objectAtIndex:0];
           NSLog(@"ds3ttt3333  %@",self.childViewControllers);
       // [self.fiistViw addlefMen];
      //  UIView *  view=  self.childViewControllers[0].view ;
        //[view removeFromSuperview];
     // self.view.frame = CGRectMake(120, 30, 300, 300);
       // return;
            NSLog(@"ds33333");
        CGFloat x = self.view.frame.origin.x;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if (x>=self.view.frame.size.width * 0.5) {
            
        [UIView animateWithDuration:0.25 animations:^{
          //  self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
            
            
        }completion:^(BOOL finished) {
          
            [self popViewControllerAnimated:NO];
            [self.lastVcView removeFromSuperview];
            [self.cover removeFromSuperview];
           // self.view.transform = CGAffineTransformIdentity;
            [self.images removeLastObject];
            NSLog(@"ds");
           // NSLog(@"剩下%@",self.images);
            
        }];
        }else{
            
            [UIView animateWithDuration:0.25 animations:^{
               // self.view.transform = CGAffineTransformIdentity;
            }];
            
        }
    }else{
//        
//        CGFloat  a = tx;
//        
//        CGFloat b = a+tx;
//        NSLog(@"教育");
//        self.view.transform = CGAffineTransformMakeTranslation(b, 0);
//        UIWindow * windo =[UIApplication sharedApplication].keyWindow;
//        
//     UIView * view =    [windo.subviews objectAtIndex:0];
//        
//        
//        [view removeFromSuperview];
//      //  self.lastVcView.image =  self.images[self.images.count -2];
//       // [windo insertSubview:self.lastVcView atIndex:0];
//        //[windo insertSubview:self.cover aboveSubview:self.lastVcView];
//        
//        
   }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
  //  NSLog(@"跳转");
    [super pushViewController:viewController animated:animated];
    [self createScreenShort];
    
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
