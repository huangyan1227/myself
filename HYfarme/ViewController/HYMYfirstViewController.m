//
//  HYMYfirstViewController.m
//  HYfarme
//
//  Created by bidiao on 16/3/2.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "HYMYfirstViewController.h"
#import "HYLeftView.h"
#import "HYHomeViewController.h"
#import "HYTitleView.h"


#import "HYMessageViewController.h"
#import "HYHomeViewController.h"
#define  HYNavShowAnimDuration 0.5
#define  HYCoverTag 100
@interface HYMYfirstViewController ()<HYLeftViewDelegate>
@property(nonatomic,weak) HYLeftView * leftView;
//@property(nonatomic,weak) HYNavigationViewController * shownavigationCotroller;
@property(nonatomic,weak) UIImageView * imageview;
@property(nonatomic,strong) HYHomeViewController * hy;
@property(nonatomic,strong) UIButton * clickbutton;

@end


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@implementation HYMYfirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageBackView];
    [self addChildViewControllerm];
      [self lefView];
   // [self padnView];
}
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}
-(void)imageBackView{
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image =[UIImage imageNamed:@"sidebar_bg"];
    [self.view addSubview:imageView];
   // NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);

}
-(void)lefView{
    
    HYLeftView *lefMenuView =[[HYLeftView alloc]init];
    lefMenuView.y=60;
    lefMenuView.height = 300;
    lefMenuView.width = 200;
    lefMenuView.delegatem =self;
    [self.view insertSubview:lefMenuView atIndex:1];
    self.leftView =lefMenuView;
    
    

}
-(void)addChildViewControllerm{
    
    //HYHomeViewController * news=[[HYHomeViewController alloc]init];
    
    //UIViewController * news =[[UIViewController alloc]init];
   // [self setupVc:news title:@"首页"];
    HYShouViewController *news =[HYShouViewController new];
   // news.myViewColvt = self;
    [ self addOneChlildVc:news title:@"首f页" imageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];
   // [self.view addSubview:_shownavigationCotroller.view];
    UIViewController * readingNews =[[UIViewController alloc]init];
   // [self setupVc:readingNews title:@"订阅"];
    [ self addOneChlildVc:readingNews title:@"订阅" imageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];
    
    UIViewController * photo =[[UIViewController alloc]init];
    //[self setupVc:photo title:@"图片"];
    [ self addOneChlildVc:photo title:@"图片" imageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];
    UIViewController *video =[[UIViewController alloc]init];
    //[self setupVc:video title:@"视屏"];
    [ self addOneChlildVc:video title:@"视频" imageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];
    UIViewController *comment = [[UIViewController alloc]init];
    //[self setupVc:comment title:@"跟帖"];
    [ self addOneChlildVc:comment title:@"跟帖" imageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];
    UIViewController *radio =[[UIViewController alloc]init];
   // [self setupVc:radio title:@"电台"];
    [ self addOneChlildVc:radio title:@"电台" imageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];

    

    
}
-(void)addOneChlildVc:(UIViewController *)chilVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName {
    
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
    //设置选中的图片
    UIImage *selectedImage = [UIImage imageWithName:selectImageName];
    //不要渲染
    selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    chilVc.tabBarItem.selectedImage = selectedImage;

    if (kDevice_Is_iPhoneX) {
        [chilVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-12, -12)];
    };
    
    
    chilVc.view.backgroundColor =HYRandomColor;
    HYTitleView *titleView =[[HYTitleView alloc]init];
    titleView.frame = CGRectMake(0, 0, 88, 65);
    titleView.title =title;
    chilVc.navigationItem.titleView = titleView;
    chilVc.navigationItem.leftBarButtonItem =[UIBarButtonItem  itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(lefMen)];
    HYNavigationViewController * navi =[[HYNavigationViewController alloc]initWithRootViewController:chilVc];

    navi.navigationBar.tintColor=[UIColor orangeColor];
    
    
    HYMainViewController * maiv =[[HYMainViewController alloc]init];
    
    maiv.viewControllers = @[navi];
  
   //[self addChildViewController:navi];
   
    
    [maiv addChildviewcontroller];
    
    [self addChildViewController:maiv];
    
}
////没用的的
//-(void)setupVc:(UIViewController *)vc title:(NSString *)title{
//    
//    vc.view.backgroundColor =HYRandomColor;
//    HYTitleView *titleView =[[HYTitleView alloc]init];
//    titleView.title =title;
//    vc.navigationItem.titleView = titleView;
//    vc.navigationItem.leftBarButtonItem =[UIBarButtonItem  itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(lefMen)];
// HYNavigationViewController * navi =[[HYNavigationViewController alloc]initWithRootViewController:vc];
//    navi.navigationBar.tintColor=[UIColor orangeColor];
//    HYMainViewController * maiv =[[HYMainViewController alloc]init];
//    [maiv addChildViewController:navi];
////    HYHomeViewController *hone=   [HYHomeViewController new];
////    hone.title =@"好久";
//  
////  HYNavigationViewController *k=[[HYNavigationViewController alloc]initWithRootViewController:hone];
//    
//    //[maiv addChildviewcontroller];
////    HYMessageViewController *messa=[HYMessageViewController new];
////    messa.title=@"djljs";
//   // HYNavigationViewController *mae=[[HYNavigationViewController alloc]initWithRootViewController:messa];
//    //maiv.viewControllers=@[navi,k,mae];
//    //[maiv addChildviewcontroller];
//    //self.mytabl =maiv;
//    
//    [self addChildViewController:maiv];
//    
//}
//-(void)addlefMen{
//    
//    [self lefMen];
//}
-(void)lefMen{
    self.leftView.hidden = NO;
    [UIView animateWithDuration:HYNavShowAnimDuration animations:^{
        
        UIView * view =self.shownavigationCotroller.view;
        CGFloat navi =[UIScreen mainScreen].bounds.size.height -2*60;
        CGFloat scale =navi/[UIScreen mainScreen].bounds.size.height;
        CGFloat leftMenuMargin =[UIScreen mainScreen].bounds.size.width*(1-scale)*0.5;
        CGFloat translateX = 200-leftMenuMargin;
        CGFloat topMargin =[UIScreen mainScreen].bounds.size.height *(1-scale)*0.5;
        CGFloat translateY =topMargin -60;
        
        //缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(1, 1);
        //平移
        CGAffineTransform translateForm =CGAffineTransformTranslate(scaleForm, translateX/scale, translateY/scale);
        view.transform =translateForm;
        //遮盖
        UIButton * cover =[[UIButton alloc]init];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = view.bounds;
        cover.tag =HYCoverTag;
        [view addSubview:cover];
        //self.clickbutton = cover;
        
    }];
    
    
    
}
-(void)coverClick:(UIView *)cover{
    
    [UIView animateWithDuration:HYNavShowAnimDuration animations:^{
        self.shownavigationCotroller.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
    
    
}

-(void)leftMenu:(HYLeftView *)menu didSelectedButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
    HYNavigationViewController *ildNav =self.childViewControllers[fromIndex];
    //ildNav.dd =self;
    [ildNav.view removeFromSuperview];
    HYNavigationViewController *nave =self.childViewControllers[toIndex];
    [self.view addSubview:nave.view];
    
    nave.view.transform =ildNav.view.transform;
    nave.view.layer.shadowColor=[UIColor blackColor].CGColor;
    nave.view.layer.shadowOffset = CGSizeMake(-3, 0);
    nave.view.layer.shadowOpacity = 0.4;

    self.shownavigationCotroller =nave;
    [self coverClick:[nave.view viewWithTag:HYCoverTag]];
    
}



-(void)padnView{
    UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    
    
    
    
    
    
}


-(void)pan:(UIPanGestureRecognizer *)gr{
    
    //CGPoint poing =[gr translationInView:self.view];
    //NSLog(@"FF3333333333F%@",poing);
    if (gr.state==UIGestureRecognizerStateEnded||gr.state==UIGestureRecognizerStateCancelled){
        
        NSLog(@"drrrrrrrrrrrrrrrrd");
        
       [self coverClick:[self.shownavigationCotroller.view viewWithTag:HYCoverTag]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
