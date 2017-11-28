//
//  ScienceViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/17.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "ScienceViewController.h"
#import "SubLBXScanViewController.h"
#import "MyQRViewController.h"
@interface ScienceViewController ()<LBXScanViewControllerDeleate>

@end

@implementation ScienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self addbutton:@"二维码" sel:@selector(blick) farem:CGRectMake(20, 70, 150, 90)];
    
    [self addbutton:@"生成二维码" sel:@selector(addQR) farem:CGRectMake(20, 200, 150, 90)];
    
    
}
-(void)addbutton:(NSString *)title sel:(SEL)action farem:(CGRect)frame{
    
    
    UIButton * scanButton = [[UIButton alloc]init];
    
    scanButton.frame =frame ;
    
    [scanButton setTintColor:[UIColor blueColor]];
    
    [scanButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [scanButton setTitle:title forState:UIControlStateNormal];
    
    [self.view addSubview:scanButton];
    
    
    
}
-(void)addQR{
    
    MyQRViewController  *  qr = [MyQRViewController new];
    
    
    
    
   // [self presentViewController:qr animated:YES completion:nil];
    [self.navigationController pushViewController:qr animated:YES];
    
    
    
}
-(void)blick{
    
    
    [self scanweixinStyle];
    
    
    
    
}
-(void)scanweixinStyle{
    
    LBXScanViewStyle * style = [[LBXScanViewStyle alloc]init];
   
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;

     //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle =  LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    
    UINavigationController * an =[[UINavigationController alloc]initWithRootViewController:vc];
    
    vc.scandelegate = self;

    [self presentViewController:an animated:YES completion:nil];

    
}
-(void)result:(NSString *)resultString{
    
   // self.strSCan = resultString;
    
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(12, 200, 300, 100)];
    
    [self.view addSubview:lable];
    
    
    
    //if (self.strSCan.length > 0) {
    lable.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
     //是否更新字体的变化
    lable.adjustsFontForContentSizeCategory = YES;
        lable.text = resultString;
        
        // NSLog(@"ggg%@",self.strSCan);
   // }
    self.strSCan = nil;
    
    
    
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
