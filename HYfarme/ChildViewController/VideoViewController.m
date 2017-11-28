//
//  VideoViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/17.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "VideoViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "HYVideoTableViewCell.h"
#import "MJRefresh.h"
#import "DWURunLoopWorkDistribution.h"

@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger  _offset;
}

@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSArray * taNarry;

@property (nonatomic, strong) NSMutableArray * modelsArray;
@property (nonatomic, strong) NSMutableArray * contenAry;
@end

@implementation VideoViewController

- (NSMutableArray *)modelsArray {
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    return _modelsArray;
}

- (NSMutableArray *)contenAry {
    if (!_contenAry) {
        _contenAry = [NSMutableArray array];
    }
    return _contenAry;
}



-(UITableView *)tableView {
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-150) style:UITableViewStylePlain];
        
    }
    
    return _tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      _offset = 1;//初始值
    //添加tableview
    [self addTableView];
    
     [self AddRefreshAndLoadMore];//上啦刷新,下拉加载
   // self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor greenColor];

}
- (void)AddRefreshAndLoadMore {
    
   //下来刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(handleRefresh)];
    
    self.tableView.mj_header = header;
    
    [header setTitle:@"正在向上加载" forState:MJRefreshStateIdle];
    
    [header setTitle:@"正在加载" forState:MJRefreshStatePulling];
    
    [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    
    //添加上拉刷新
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
    
    
     
   // [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在向下加载" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"正在加载" forState:MJRefreshStatePulling];
    
    [footer setTitle:@"加 载 中" forState:MJRefreshStateRefreshing];

  //   footer.refreshingTitleHidden = YES;
    
    self.tableView.mj_footer = footer;
    
    
    footer.stateLabel.hidden = NO;
    
    // Set font
  //  footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // Set textColor
   // footer.stateLabel.textColor = [UIColor blueColor];
    //Become the status of NoMoreData
  //  [footer noticeNoMoreData];
    
}

#pragma mark - handle refresh and load more

- (void)handleRefresh {//刷新
   // _offset = 0;
    
    [self.tableView reloadData];
    
    //停止刷新
    // [self.tableView reloadData];
    NSLog(@"ggf");
    [self.tableView.mj_header endRefreshing];
    //[self loadData:[NSString stringWithFormat:kURL, _offset]];//重新加载网络请求
}

- (void)handleLoadMore {//加载更多
    
    [self.modelsArray addObjectsFromArray:self.taNarry];
    [self.tableView reloadData];
    
    //停止刷新
   // [self.tableView reloadData];
    NSLog(@"ggf");
    [self.tableView.mj_footer endRefreshing];
  //  _offset = self.modelsArray.count;
    //[self loadData:[NSString stringWithFormat:kURL, _offset]];//重新加载网络请求
}


-(void)addTableView{
    
    self.tableView.backgroundColor = [UIColor orangeColor];
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的kdfgjflsdkjglkdjgldfkjglkdfjglkdfjglkfdjglkdfjgkdlfjglkdfgjdlkfjglkdfjglkdfjlkgjdflkgjlkdfjgldkfjgldkfjgdlkfjgdlkfjgdlk app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下，"
                           ];
    self.taNarry = textArray;
    [self.modelsArray addObjectsFromArray:textArray];

    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.modelsArray.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MyCell";
    HYVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HYVideoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
//    //干掉contentView上面的子控件!! 节约内存!!
//    for (NSInteger i = 1; i <= 6; i++) {
//        //干掉contentView 上面的所有子控件!!
//        [[cell.contentView viewWithTag:i] removeFromSuperview];
//    }
    
    cell.currentIndexPath = indexPath;
   
     [[DWURunLoopWorkDistribution sharedRunLoopWorkDistribution] addTask:^BOOL{
         
         if (![cell.currentIndexPath isEqual:indexPath]) {
             return NO;
         }

         cell.text =self.modelsArray[ indexPath.row];
         
         
         cell.textColor = [UIColor yellowColor];
              return YES;
         
     } withKey:indexPath];
//
  //  cell.text =self.modelsArray[ indexPath.row];
    //
    //
       // cell.textColor = [UIColor yellowColor];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

    
    
    
    
    
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"ggggh");
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * text = self.modelsArray[indexPath.row];
    
    return [self.tableView cellHeightForIndexPath:indexPath model:text keyPath:@"text" cellClass:[HYVideoTableViewCell  class] contentViewWidth:[self cellContentViewWith]];
    
}
-(CGFloat)cellContentViewWith{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;

    
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.layoutMargins = UIEdgeInsetsZero;
    
    cell.preservesSuperviewLayoutMargins = NO;
    
    
    
    
}
//-(CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView{
//    
//    
//    
//    
//}
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
