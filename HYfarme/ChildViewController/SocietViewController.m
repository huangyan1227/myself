//
//  SocietViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/17.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "SocietViewController.h"
#import "JWPlayer.h"
#import "VideoMode.h"
#import "VideoTableViewCell.h"
#import "UIView+CLSetRect.h"
#import "CLPlayerView.h"
#import "MJRefresh.h"
#import "DWURunLoopWorkDistribution.h"


@interface SocietViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,VideoDelegate>

/**tableView*/
@property (nonatomic,strong) UITableView *tableView;

/**数据源*/
@property (nonatomic,strong) NSMutableArray *arrayDS;


/**记录Cell*/
@property (nonatomic,assign) VideoTableViewCell *cell;


@property(nonatomic,strong) NSMutableArray * modeArrls;

@end

@implementation SocietViewController

-(NSMutableArray *)arrayDS {
    if (!_arrayDS) {
        _arrayDS = [NSMutableArray array];
    }
    
    return _arrayDS;
    
}

-(NSMutableArray *)modeArrls {
    if (!_modeArrls) {
        _modeArrls = [NSMutableArray array]
        ;    }
    
    return _modeArrls;
    
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CLscreenWidth, CLscreenHeight) style:UITableViewStylePlain];
        
        
    }
    
    return _tableView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //JWPlayer*player=[[JWPlayer alloc]initWithFrame:CGRectMake(0, 100, 314,214)];
   // [player updatePlayerWith:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];
  //  [self.view addSubview:player];
    // Do any additional setup after loading the view.
  // self.view.backgroundColor = [UIColor brownColor];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self initDate];
    
    [self addRefreshAndLoadMore];
    
    [self initUI];
       // [self.tableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"MyCell"];

}

-(void)addRefreshAndLoadMore{
    
    //    //下来刷新
    //    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(handleRefresh)];
    //
    //    self.tableView.mj_header = header;
    //
    //    [header setTitle:@"正在向上加载" forState:MJRefreshStateIdle];
    //
    //    [header setTitle:@"正在加载" forState:MJRefreshStatePulling];
    //
    //    [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(handleRefresh)];
    
    self.tableView.mj_header = header;
    
    [header setTitle:@"正在向上加载" forState:MJRefreshStateIdle];
    
    [header setTitle:@"正在加载" forState:MJRefreshStatePulling];
    
    [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    
    
//    //添加上拉刷新
//    
//    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
//    
//    
//    
//    // [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"正在向下加载" forState:MJRefreshStateIdle];
//    
//    [footer setTitle:@"正在加载" forState:MJRefreshStatePulling];
//    
//    [footer setTitle:@"加 载 中" forState:MJRefreshStateRefreshing];
//    
//    //   footer.refreshingTitleHidden = YES;
//    
//    self.tableView.mj_footer = footer;
//    
//    
//    footer.stateLabel.hidden = NO;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
    
   // [footer setTitle:@"正在详细加载" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"正在加tt载" forState:MJRefreshStatePulling];
    
    [footer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    
  //  self.tableView.mj_footer = footer;
    
   // footer.stateLabel.hidden = NO;
    
    
}

- (void)handleLoadMore {//加载更多
    
    //[self.modelsArray addObjectsFromArray:self.taNarry];
    
    [self initDate];
    [self.tableView reloadData];
    
    //停止刷新
    // [self.tableView reloadData];
    NSLog(@"ggf");
    [self.tableView.mj_footer endRefreshing];
    //  _offset = self.modelsArray.count;
    //[self loadData:[NSString stringWithFormat:kURL, _offset]];//重新加载网络请求
}


- (void)handleRefresh {//刷新
    // _offset = 0;
    
    
    //停止刷新
    // [self.tableView reloadData];
    NSLog(@"ggf");
    [self.tableView.mj_header endRefreshing];
    
    [self.tableView reloadData];

    //[self loadData:[NSString stringWithFormat:kURL, _offset]];//重新加载网络请求
}

-(void)initDate{
    
    //_arrayDS = [NSMutableArray array];
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Date" ofType:@"json"]];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        VideoMode *model = [VideoMode new];
        [model setValuesForKeysWithDictionary:obj];
        [self.arrayDS addObject:model];
    }];
}

-(void)initUI{
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    
   self.tableView.sectionFooterHeight = 0;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.size.mas_equalTo(CGSizeMake(90, 90));
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
        make.top.equalTo(self.view).with.offset(0);
        
        make.left.equalTo(self.view).with.offset(0);
        
        
        make.right.equalTo(self.view).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(HYKScreenW, HYKScreenH-108));
        
    }];
    

    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayDS.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MyCell";
    VideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
        //干掉contentView上面的子控件!! 节约内存!!
//        for (NSInteger i = 1; i <= 2; i++) {
//            //干掉contentView 上面的所有子控件!!
//            [[cell.contentView viewWithTag:i] removeFromSuperview];
//        }
//    cell.currentIndexPath = indexPath;
//   [ [DWURunLoopWorkDistribution sharedRunLoopWorkDistribution
//    ] addTask:^BOOL{
//       
//       
//       if (![cell.currentIndexPath isEqual:indexPath]) {
//           return NO;
//       }
//       
//       cell.model =self.arrayDS[ indexPath.row];
//       cell.videoDelegate = self;
//       
//
//       
//     //  cell.textColor = [UIColor yellowColor];
//       return YES;
//
//       
//    } withKey:indexPath];
    // cell.videoDelegate = self;
    cell.backgroundColor =[ UIColor clearColor];
        return cell;

    
    
}
//在willDisplayCell里面处理数据能优化tableview的滑动流畅性
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoTableViewCell * myCell = (VideoTableViewCell *)cell;
    
    myCell.model = self.arrayDS[indexPath.row];
    
    //Cell开始出现的时候修正偏移量，让图片可以全部显示
   //[myCell cellOffset];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

#pragma mark - 点击播放代理
- (void)PlayVideoWithCell:(VideoTableViewCell *)cell;
{
    //记录被点击的Cell
    _cell = cell;
    
    //销毁播放器
    [_playerView destroyPlayer];
    _playerView = nil;
    
    _playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, cell.CLwidth, cell.CLheight)];
    [cell.contentView addSubview:_playerView];
    
    //根据旋转自动支持全屏，默认支持
    //        _playerView.autoFullScreen = NO;
    //重复播放，默认不播放
    //    _playerView.repeatPlay     = YES;
    //如果播放器所在页面支持横屏，需要设置为Yes，不支持不需要设置(默认不支持)
    //    _playerView.isLandscape    = YES;
    
    //视频地址
    _playerView.url = [NSURL URLWithString:cell.model.videoUrl];
    
    //播放
    [_playerView playVideo];
    
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
        //根据旋转自动支持全屏，默认支持
        //        _playerView.autoFullScreen = NO;
       // [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //播放完成回调
    [_playerView endPlay:^{
        
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
        NSLog(@"播放完成");
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"滚动哦了");
    // visibleCells 获取界面上能显示出来了cell
    NSArray<VideoTableViewCell *> *array = [self.tableView visibleCells];
    
    //enumerateObjectsUsingBlock 类似于for，但是比for更快
    [array enumerateObjectsUsingBlock:^(VideoTableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"ffgg");
        [obj cellOffset];
        
    }];
    
    
    [_playerView calculateWith:_tableView cell:_cell topOffset:64 bottomOffset:0 beyond:^{
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    NSLog(@"消失");
    
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
