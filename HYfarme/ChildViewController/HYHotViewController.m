//
//  HYHotViewController.m
//  HYfarme
//
//  Created by bidiao on 17/4/18.
//  Copyright © 2017年 bidiao. All rights reserved.
//

#import "HYHotViewController.h"
#import "ZLPhotoActionSheet.h"
#import "ZLShowBigImage.h"
@interface HYHotViewController ()
{
    ZLPhotoActionSheet *actionSheet;
}
@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property(nonatomic,strong) UIImageView * imviewg;
@end

@implementation HYHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button = [[UIButton alloc]init];
    
    button.frame = CGRectMake(10, 100, 80, 100);
    
    [button setBackgroundColor:[UIColor yellowColor]];
    
    [self.view addSubview:button];
    self.view.backgroundColor = [UIColor whiteColor];
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 5;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;

    UIImageView * imageview =[[UIImageView alloc]init];
    
    imageview.frame =  CGRectMake(150, 40, 230, 200);
    self.imviewg = imageview;
    [self.view addSubview:imageview];
    
    
    [button addTarget:self action:@selector(photho) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonshowimage =[[UIButton alloc]init];
    
    buttonshowimage.frame = CGRectMake(80, 290, 100, 140);
    
    buttonshowimage.backgroundColor  =[UIColor redColor];
    [self.view addSubview:buttonshowimage];
    
    [buttonshowimage addTarget:self action:@selector(clickimage) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)clickimage{
    
    
    
    [ZLShowBigImage showBigImage:self.imviewg];
    
}
-(void)photho{
    
    __weak typeof(self) weakSelf = self;
    
    [actionSheet  showPreviewPhotoWithSender:self animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        
        weakSelf.imviewg.image = selectPhotos[0];
        NSLog(@" %@ ",selectPhotos);
        
        
    }];
    
    
    
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
