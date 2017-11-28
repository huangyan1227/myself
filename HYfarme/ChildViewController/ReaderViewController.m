//
//  ReaderViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/17.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "ReaderViewController.h"
#import "PYSearch.h"
#import "MJRefresh.h"


@interface ReaderViewController ()<PYSearchViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;

@end

@implementation ReaderViewController

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    
    return _tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addRefreshAndLoadMore];
    [self.view addSubview:self.tableView];
   //self.view.backgroundColor = [UIColor blueColor];

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
    
    
}

- (void)handleRefresh {//刷新
    // _offset = 0;
    
    [self.tableView reloadData];
    
    //停止刷新
    // [self.tableView reloadData];
    NSLog(@"ggf");
    [self.tableView.mj_header endRefreshing];
    //[self loadData:[NSString stringWithFormat:kURL, _offset]];//重新加载网络请求
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"MyCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    
    cell.textLabel.text =@"wo ";
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    PYSearchViewController * searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
        NSLog(@"gghh %@",searchText);
        
    }];
    // 选择热门搜索
    searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
    
    NSLog(@"jjjjkkkk");
    
    
}
-(void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText{
    
    if (searchText.length) {
         NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@" %@",searchText);
            
            // 1.创建热门搜索
            
            
           
            searchViewController.searchSuggestions = hotSeaches;
            
            
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSString *p in hotSeaches) {
                NSRange range = [p rangeOfString:searchText];
                if (range.location != NSNotFound) {
                    
                    [tempArr addObject:p];
                }
            }

            searchViewController.searchSuggestions = tempArr;
            
            
        });
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.layoutMargins = UIEdgeInsetsZero;
    
    cell.preservesSuperviewLayoutMargins = NO;
    
    
    
    
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
