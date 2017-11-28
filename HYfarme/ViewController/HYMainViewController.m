//
//  HYMainViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/2.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYMainViewController.h"
#import "HYHomeViewController.h"
#import "HYTabBar.h"
#import "HYMessageViewController.h"
#import "HYAddViewController.h"
#import "HYheaderViewController.h"
#import "HYNavigationViewController.h"
#import "HYSeacherViewController.h"
#import "UIView+Extension.h"

#import "HYLeftView.h"
@interface HYMainViewController ()<HYTabBarDelegate>
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self addChildviewcontroller];
    //跟换系统
    [self addCustomTabar];
//   HYheaderViewController *header = [HYheaderViewController new];
////
//    
//       [self addChildViewController:header];
    //添加左菜单
    //[self leftview];
    
  //  NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
  // [self panView];
}
-(void)panView{
    UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    
    
    
    
    
    
}
-(void)pan:(UIPanGestureRecognizer *)gr{
    
   // CGPoint poing =[gr translationInView:self.view];
  //  NSLog(@"FFFFFFFFFFF%@",poing);
    if (gr.state==UIGestureRecognizerStateEnded||gr.state==UIGestureRecognizerStateCancelled){
        
        
        NSLog(@"d00000000000d");
        
        
    }
}
-(void)leftview{
    
    
}
-(void)addCustomTabar{
    
    HYTabBar *tabar =[[HYTabBar alloc]init];
    tabar.delegatehy =self;
    //[tabar setShadowImage:[UIImage imageNamed:@"cance"]];
   tabar.backgroundColor =[UIColor whiteColor];
    //[self.view addSubview:self.tabBar];
    [self setValue:tabar forKey:@"tabBar"];
   // [self.tabBar removeFromSuperview];
    
    
}
-(void)addChildviewcontroller{
//  
//    HYHomeViewController *home = [[HYHomeViewController alloc] init];
//    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    HYMessageViewController *message = [[HYMessageViewController alloc] init];
    [self addOneChlildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    HYSeacherViewController *discover = [[HYSeacherViewController alloc] init];
    [self addOneChlildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    //UIViewController *profile = [[UIViewController alloc] init];
  //  [self addOneChlildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    
    HYheaderViewController *header = [HYheaderViewController new];
    //
       [self addChildViewController:header];
    [self addOneChlildVc:header title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
   // header.view.backgroundColor = [UIColor orangeColor];
    
}
-(void)vieNsarray:(UINavigationController *)array{
    
    //self.viewControllers =@[array];

    
    //self addChildViewController:<#(nonnull UIViewController *)#>
}
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}
-(void)addOneChlildVc:(UIViewController *)chilVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName{
    
    chilVc.title = title;
    chilVc.tabBarItem.image =[UIImage imageWithName:imageName];
    //设置tabarItem的普通文字颜色
    NSMutableDictionary *textAttrs =[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor blackColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:10];
    [chilVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //选中时候的tabarItem的文字颜色
    NSMutableDictionary *selectedtextAttrs =[NSMutableDictionary dictionary];
    selectedtextAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [chilVc.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    if (kDevice_Is_iPhoneX) {
        
        [chilVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-12, -12)];
    };
    
    //设置选中的图片
    UIImage *selectedImage = [UIImage imageWithName:selectImageName];
    //不要渲染
    selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    chilVc.tabBarItem.selectedImage = selectedImage;
    
 HYNavigationViewController*navi =[[HYNavigationViewController alloc]initWithRootViewController:chilVc];
   // self.tabBar.backgroundColor =[UIColor yellowColor];
          [self addChildViewController:navi];
}

-(void)tabBarDidClickedPlusButton:(HYTabBar *)tabBar{

    
    //tabBar.delegate =self;
    HYAddViewController *addView =[HYAddViewController new];
        [self presentViewController:addView animated:YES completion:nil];
    
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
       
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
