//
//  HYShouViewController.m
//  HYfarme
//
//  Created by bidiao on 16/7/8.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "HYShouViewController.h"
#import "HLLocationManager.h"
#import "YZNavigationMenuView.h"

@interface HYShouViewController ()<YZNavigationMenuViewDelegate>
@property(nonatomic,strong) UILabel * lable;
@property(nonatomic,strong) YZNavigationMenuView * menView;
@end
#define kNaHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?20:0)
@implementation HYShouViewController

-(YZNavigationMenuView *)menView {
    if (!_menView) {
        
        //获取数据
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 6; i++) {
            NSString *name = [NSString stringWithFormat:@"%d",i + 1];
            UIImage *image  = [UIImage imageNamed:name];
            [imageArray addObject:image];
            
        }

        
        _menView =[[YZNavigationMenuView alloc]initWithPositionOfDirection:CGPointMake(self.view.frame.size.width-24, 64) images:imageArray titleArray:@[@"我是第一栏",@"我是第二栏",@"我是第三栏",@"我是第四栏",@"我是第五栏",@"我是最后一栏",]];;
    }
    
    return _menView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self panView];
   // [UIColor gr]
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addselt:)];
    
   // self.navigationController;
    
    
    UILabel * lable =[[ UILabel alloc]init];
    
    lable.frame =CGRectMake(20, 189+kNaHeight, 200, 300);
    lable.numberOfLines = 0;
    [self.view addSubview:lable];
    self.lable = lable;
    
    UIButton * lococtionButton =[[UIButton alloc]init];
    
    lococtionButton.frame = CGRectMake(20, 60+kNaHeight, 150, 90);
    
    [lococtionButton addTarget:self action:@selector(blickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [lococtionButton setTitle:@"定位" forState:UIControlStateNormal];
    
    [lococtionButton setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:lococtionButton];
    
    
    
}
- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

-(void)addselt:(UIBarButtonItem *)item{
    
    
   
//    //获取数据
//    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
//    for (int i = 0; i < 6; i++) {
//        NSString *name = [NSString stringWithFormat:@"%d",i + 1];
//        UIImage *image  = [UIImage imageNamed:name];
//        [imageArray addObject:image];
//        
//    }
//    
//    YZNavigationMenuView * menView = [[YZNavigationMenuView alloc]initWithPositionOfDirection:CGPointMake(self.view.frame.size.width-24, 64) images:imageArray titleArray:@[@"我是第一栏",@"我是第二栏",@"我是第三栏",@"我是第四栏",@"我是第五栏",@"我是最后一栏",]];
//   
   // self.menView = menView;
    _menView.delegate =self;
    
//    menView.clickedBlock = ^(NSInteger index){
//        
//         NSLog(@"gg 第%ld栏 ",index+1);
//        
//        
//    };

    [self.view addSubview:self.menView];
    NSLog(@"gg");
    
}
-(void)navigationMenuView:(YZNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index{
    
    NSLog(@"----我是第%ld",index+1);
}
-(void)blickButton{
    
    
   
    [[HLLocationManager sharedHLLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
        if (error) {
            NSLog(@"定位出错,错误信息:%@",error);
        }else{
            NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@  \n location详细信息:%@ \n ",location.coordinate.latitude, location.coordinate.longitude, placeMark.name, location);
            [_lable setText:[NSString stringWithFormat:@"定位成功:经度:%f 纬度:%lf 当前地址:%@  \n location详细信息:%@ \n ",location.coordinate.latitude, location.coordinate.longitude, placeMark.name, location]];
        }
    } onViewController:self];

    
    
    
}
-(void)panView{
    UIPanGestureRecognizer * pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    
    
    
    
}
-(void)pan:(UIPanGestureRecognizer *)gr{
    
    
    if (gr.state==UIGestureRecognizerStateEnded||gr.state==UIGestureRecognizerStateCancelled){
        
        NSLog(@"dd");
         [self commitTranslation:[gr translationInView:self.view]];
        
  
    }
    }

- (void)commitTranslation:(CGPoint)translation
{
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) < 10)
        return;
    
    
    if (absX > absY ) {
        
        if (translation.x<0) {
            NSLog(@"向左");
            //向左滑动
        }else{
             NSLog(@"向右");
            [self.myViewColvt addlefMen ];
            //向右滑动
        }
        
    } else if (absY > absX) {
        if (translation.y<0) {
             NSLog(@"向上");
            //向上滑动
        }else{
             NSLog(@"向下");
            //向下滑动
        }
    }
    
    
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
