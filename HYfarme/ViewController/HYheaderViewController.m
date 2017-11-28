//
//  HYheaderViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/17.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYheaderViewController.h"
#import "HYTopViewController.h"
#import "HYHotViewController.h"
#import "VideoViewController.h"
#import "SocietViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"

#import "Masonry.h"
static CGFloat const titleH = 44;
static CGFloat const navBarH = 64;
static CGFloat const maxTitleScale = 1.3;
//#define HYKScreenW [UIScreen mainScreen].bounds.size.width
//#define HYKScreenH [UIScreen mainScreen].bounds.size.height
@interface HYheaderViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIButton * selTitleButton;
@property(nonatomic,strong) NSMutableArray * buttons;
@property(nonatomic,weak) UIScrollView * titileScrollView;
@property(nonatomic,weak) UIScrollView * contentScrollView;
@property(nonatomic,strong)  SocietViewController *vc3 ;
@end
#define kNaHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?20:0)
@implementation HYheaderViewController
-(NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  self.title = @"好";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTitleScrollView];
    [self setupContentScrolllView];
    [self addChilViewContrllername];
    [self setupTitle];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count*HYKScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate =self;
    self.titileScrollView.backgroundColor = [UIColor grayColor];
    self.contentScrollView.alwaysBounceHorizontal= NO;
   // [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
  //  self.view.backgroundColor = [UIColor yellowColor];
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cance"] forBarMetrics:UIBarMetricsDefault];
   self.navigationController.navigationBar.translucent = YES;
    //self.contentScrollView.scrollsToTop = NO;
   // [self tianjiadaoscrollView];
    
   
}
//-(void)tianjiadaoscrollView{
//    
//    
//    NSUInteger count = self.childViewControllers.count;
//    for (int i =0; i<count; i++) {
//        
//        
//        CGFloat x = i * HYKScreenW;
//        
//        UIViewController *vc = self.childViewControllers[i];
//        
////        if (vc.view.superview) {
////            return;
////        }
//        vc.view.frame = CGRectMake(x, 0, HYKScreenW, HYKScreenH - 108);
//        
//        [self.contentScrollView addSubview:vc.view];
//    }
//    
//    
//    
//}
//设置标题/Users/bidiao/Desktop/self项目
-(void)setupTitleScrollView{
    /**
     *  判断是否存在导航控制器来判断y值
     */
    CGFloat y = self.navigationController ? navBarH+kNaHeight :0;
    CGRect rect = CGRectMake(0, y, HYKScreenW, titleH);
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [self.view addSubview:scrollView];
  
    
    
 // CGFloat d =  self.navigationController.navigationBar.frame.size.height;
    
   // NSLog(@"%ffgg",d);
    self.titileScrollView.backgroundColor = [UIColor yellowColor];
    self.titileScrollView = scrollView;
   
    
    

}
//设置内容
-(void)setupContentScrolllView{
    
    CGFloat y = CGRectGetMaxY(self.titileScrollView.frame);
    CGRect rect = CGRectMake(0, y, HYKScreenW, HYKScreenH -108);
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:rect];
    
    self.contentScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentScrollView];
    self.contentScrollView= contentScrollView;
    //__weak typeof(self) weakSelf = self;
    
//    
//    [self.titileScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        // make.size.mas_equalTo(CGSizeMake(90, 90));
//       // make.edges.mas_offset(UIEdgeInsetsMake(64, 0, 0, 0));
//        //
//        //            make.top.equalTo(self.view).with.offset(64);
//        //
//        //          make.left.equalTo(self.view).with.offset(0);
//        //
//        //         make.bottom.equalTo(self.view).with.offset(0);
//        //        make.right.equalTo(self.view).with.offset(0);
//        
//        
//        make.top.equalTo(self.view).offset(64);
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        //make.bottom.equalTo(self.view).offset(0);
//        make.size.mas_equalTo(CGSizeMake(HYKScreenW, titleH));
//        
//    }];
//    
//
//    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        ///make.top(weakSelf.titileScrollView)
        //make.top.equalTo(view1.mas_bottom).with.offset(20);
       // make.top.equalTo(weakSelf.titileScrollView.mas_bottom).with.offset(0);
//            make.top.equalTo(self.view).with.offset(108);
//    
//                  make.left.equalTo(self.view).with.offset(0);
//          make.bottom.equalTo(self.view).with.offset(0);
//        
//                make.right.equalTo(self.view).with.offset(0);
        
//        make.top.equalTo(self.titileScrollView).offset(40);
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view).offset(0);
//        
//
//        //
//
//       // make.edges.mas_offset(UIEdgeInsetsMake(108,0, 0, 0));
//        
//     //   make.size.mas_equalTo(CGSizeMake(HYKScreenW,  HYKScreenH -108));
//
//        
//    }];
    contentScrollView.bounces = NO;
    //[self.view addSubview:contentScrollView];
   /// self.contentScrollView= contentScrollView;
    
}
//添加子控制器
-(void)addChilViewContrllername{
    
    HYTopViewController * top = [HYTopViewController new];
    [self addchildTitle:@"头条" viewController:top];
   
    HYHotViewController * hot = [HYHotViewController new];
    [self addchildTitle:@"热点" viewController:hot];
   
    VideoViewController *vc2 = [[VideoViewController alloc] init];
    [self addchildTitle:@"社会" viewController:vc2];
   
    SocietViewController *vc3 = [[SocietViewController alloc] init];
  [self addchildTitle:@"视频" viewController:vc3];
    
  //  self.vc3 = vc3;
    
    ReaderViewController *vc4 = [[ReaderViewController alloc] init];
    [self addchildTitle:@"订阅" viewController:vc4];
    
     ScienceViewController *vc5 = [[ScienceViewController alloc] init];
    [self addchildTitle:@"科技" viewController:vc5];
    
}
-(void)addchildTitle:(NSString*)title viewController:(UIViewController*)vc{
    
       vc.title = title;
    [self addChildViewController:vc];
    


    //[self addSubview:vc.view];
}
//设置标题
-(void)setupTitle{
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat w = 100;
    CGFloat h= titleH;
    
    for ( int  i =0; i< count; i++) {
        UIViewController * vc =self.childViewControllers[i];
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
       // btn.backgroundColor = [UIColor yellowColor];
       // btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titileScrollView addSubview:btn];
        
        if (i == 0)
        {
            [self chick:btn];
        }
      //  CGFloat xa = i * HYKScreenW;
        
      //  [self setUpOneChildViewController:i];
      //  self.contentScrollView.contentOffset = CGPointMake(xa, 0);

    }
    self.titileScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titileScrollView.showsHorizontalScrollIndicator = NO;

   

    
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
   
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewWillBeginDragging");
    
//    NSUInteger i = self.contentScrollView.contentOffset.x / HYKScreenW;
//   
//    
//    [self selTitleBtn:self.buttons[i]];
//    
   // NSLog(@"gg%lu",(unsigned long)i);
//    [self setUpOneChildViewController:i];
//     NSLog(@"开始");
//    
//    NSUInteger count = self.childViewControllers.count;
//    for (int i =0; i<count; i++) {
//        
//    
//    CGFloat x = i * HYKScreenW;
//    
//    UIViewController *vc = self.childViewControllers[i];
//    
//    if (vc.view.superview) {
//        return;
//    }
//    vc.view.frame = CGRectMake(x, 0, HYKScreenW, HYKScreenH - self.contentScrollView.frame.origin.y);
//    
//    [self.contentScrollView addSubview:vc.view];
//    }
    
    
}
- (void)chick:(UIButton *)btn
{
    NSLog(@"dianji ");
    [self selTitleBtn:btn];
    
    NSUInteger i = btn.tag;
    CGFloat x = i * HYKScreenW;
    
    [self setUpOneChildViewController:i];
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
}
- (void)selTitleBtn:(UIButton *)btn
{
    
   
    [self.selTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);
    
     self.selTitleButton = btn;
    [self setupTitleCenter:btn];
}
- (void)setUpOneChildViewController:(NSUInteger)a
{
    
    
    NSLog(@"%lu",(unsigned long)a);
    
    
    NSInteger  concut= self.childViewControllers.count;
    
    for (int i=0; i<concut; i++) {
    
        
        
        CGFloat x = i * HYKScreenW;
        
        UIViewController *vc = self.childViewControllers[i];
        
        
        
        if (vc.view.superview) {
            return;
        }
        vc.view.frame = CGRectMake(x, 0, HYKScreenW, HYKScreenH - self.contentScrollView.frame.origin.y);
        
        [self.contentScrollView addSubview:vc.view];
    };
    
   
    
   
    
}

- (void)setupTitleCenter:(UIButton *)btn
{
    CGFloat offset = btn.center.x - HYKScreenW * 0.5;
    
    if (offset < 0)
    {
        offset = 0;
    }
    
    CGFloat maxOffset = self.titileScrollView.contentSize.width - HYKScreenW;
    if (offset > maxOffset)
    {
        offset = maxOffset;
    }
    
    [self.titileScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{  NSLog(@"dddg");
    
    
    NSUInteger i = self.contentScrollView.contentOffset.x / HYKScreenW;
    [self selTitleBtn:self.buttons[i]];
    [self setUpOneChildViewController:i];
    
  
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollViewDidScroll");
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / HYKScreenW;
    NSInteger rightIndex = leftIndex + 1;
    
    //    NSLog(@"%zd,%zd",leftIndex,rightIndex);
    
    NSLog(@"%ld",(long)leftIndex);
    
    
    UIButton *leftButton = self.buttons[leftIndex];
    
   
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        
        NSLog(@"<");
        rightButton = self.buttons[rightIndex];
       
             }
      
    
    
    CGFloat scaleR = offsetX / HYKScreenW - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    
     // [self.vc3.playerView destroyPlayer];
    
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
    
   
   
    NSLog(@"滚动中");
  
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
