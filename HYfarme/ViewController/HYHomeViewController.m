//
//  HYHomeViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/3.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYHomeViewController.h"
#import "FistrViewController.h"
#import "SXMarquee.h"
#import "UIColor+Wonderful.h"
//#import "UIColor+Separate.h"
@interface HYHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@end

@implementation HYHomeViewController
//-(UITableView*)tableView{
//    
//    if (!_tableView) {
//        _tableView =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    }
//    return _tableView;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title=@"我还是";
   // NSLog(@"第二个");
//    self.tableView =[[UITableView alloc]init];
//    self.tableView.frame = self.view.bounds;
//   // UINavigationBar *bar =[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 70, 260, 80)];
//   // UINavigationItem * naviea= [[UINavigationItem alloc]initWithTitle:@"ad"];
//    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@"Riter" style:UIBarButtonItemStylePlain target:self action:@selector(rightlick)];
   // [bar pushNavigationItem:naviea animated:NO];
    
//    [self.view addSubview:self.tableView];
//    self.tableView.dataSource =self;
//    self.tableView.delegate = self;
    //[self.view setBackgroundColor:[UIColor yellowColor]];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    SXMarquee *mag =[[SXMarquee alloc]initWithFrame:CGRectMake(0, 80, 400, 80) speed:50.0 Msg:@"jia"];
    mag.backgroundColor =[UIColor redColor];
    
    [mag start];
    
    [self.view addSubview:mag];
    
    SXMarquee * mag1 =[[SXMarquee alloc]initWithFrame:CGRectMake(0, 250, 300, 90) speed:5 Msg:@"和重点是Joe" bgColor:[UIColor lightBLue] txtColor:[UIColor redColor]];
    [mag1 start];
    [self.view addSubview:mag1];
}
-(void)rightlick{
    NSLog(@"右边");
    [self.navigationController pushViewController:[FistrViewController new] animated:YES];
}
#pragma maker - UITableView Data delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"MyCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
  cell.textLabel.text =@"帅哥";
    return cell;

    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.separatorInset= UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
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
