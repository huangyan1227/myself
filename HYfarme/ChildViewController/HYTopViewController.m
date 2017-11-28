//
//  HYTopViewController.m
//  HYfarme
//
//  Created by bidiao on 15/12/17.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYTopViewController.h"
#import "MJRefresh.h"

@interface HYTopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property(nonatomic,strong) UICollectionView * collectionView;
@property(nonatomic,weak) UIPageControl * pageControl;
@property(nonatomic,weak) UIScrollView * scrollView;
@property(nonatomic,strong) NSMutableArray * muphoto;
@property(nonatomic,weak) NSTimer * timer;
@end

@implementation HYTopViewController
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize =CGSizeMake(80, 80);
        layout.minimumInteritemSpacing = 40;//列
        layout.minimumLineSpacing = 20;//行
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
       // layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView =[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.layer.masksToBounds = YES;
        _collectionView.layer.cornerRadius =20;
    }
    
    return _collectionView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  self.view.backgroundColor = [UIColor yellowColor];
    self.muphoto = [NSMutableArray array];
    
    for (int i =0; i<40; i++) {
        
        NSString *  str = [NSString  stringWithFormat:@"sdlk  %d",i];
        [self.muphoto addObject:str];
    }
    

    [self collectionViewmeth];
    
   }
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"家有人");
    [self addTime];

    
}
-(void)addTime{
    
    self.timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pageCotrolldd) userInfo:nil repeats:YES];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    NSLog(@"zhixinh");
    [super viewDidDisappear:animated];
    
    [self removetime];
}
-(void)removetime{
    
    [self.timer invalidate];
    self.timer = nil;
    
}
-(void)pageCotrolldd{
    
   // NSLog(@"afsdgg");
    NSInteger currenpage =self.pageControl.currentPage;
    currenpage++;
    if (currenpage==4) {
        currenpage=0;
    }
    CGFloat with =self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(currenpage *with, 0.f);
    [UIView animateWithDuration:.2f animations:^{
        self.scrollView.contentOffset=offset;
    }];

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removetime];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self addTime];
}
#pragma  mark -  注册collection;
-(void)collectionViewmeth{
    
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
  //  self.view.backgroundColor = [UIColor redColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.size.mas_equalTo(CGSizeMake(90, 90));
    make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
        make.top.equalTo(self.view).with.offset(0);
        
        make.left.equalTo(self.view).with.offset(0);
        
        
        make.right.equalTo(self.view).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(HYKScreenW, HYKScreenH-108));
        
    }];

    //下来刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(handleRefresh)];
    
    self.collectionView.mj_header = header;
    
    [header setTitle:@"正在向上加载" forState:MJRefreshStateIdle];
    
    [header setTitle:@"正在加载" forState:MJRefreshStatePulling];
    
    [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    

   // self.collectionView.mj_header = [MJRefreshAutoNormalFooter]
    
    //添加上拉刷新
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleLoadMore)];
    
    
    
    // [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在向下加载" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"正在加载" forState:MJRefreshStatePulling];
    
    [footer setTitle:@"加 载 中" forState:MJRefreshStateRefreshing];
    
    //   footer.refreshingTitleHidden = YES;
    
     self.collectionView.mj_footer = footer;
    
    

    //注册重用
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    //注册头 视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
    
}
-(void)handleRefresh{
    
    NSLog(@"下拉");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];

    });
    
    
}
-(void)handleLoadMore{
    
    
    NSLog(@"上拉");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_footer endRefreshing];
        
    });
    

    
    
    
    
    
}
#pragma  mark - 返回头部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView  *reusableView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
   // reusableView.backgroundColor =[UIColor redColor];
    
    if (self.scrollView ==nil) {
        
        [self scrollVIew:reusableView];
    }
    return reusableView;
    
}
#pragma mark - 添加滚动视图
-(void)scrollVIew:(UICollectionReusableView *)reusableView{
    
    UIScrollView * scrollView= [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, reusableView.bounds.size.width, reusableView.bounds.size.height);
    
    UIPageControl *pageControl =[UIPageControl new];
    pageControl.frame= CGRectMake(0, reusableView.frame.size.height - 40, reusableView.frame.size.width, 30);
        pageControl.pageIndicatorTintColor =[UIColor blackColor];
    pageControl.currentPageIndicatorTintColor =[UIColor redColor];
    pageControl.userInteractionEnabled = NO;
    scrollView.delegate = self;
    pageControl.tag = 100;
    scrollView.tag = 101;
    scrollView.bounces = NO;

    
    
    self.pageControl = pageControl;
    self.scrollView = scrollView;
    [reusableView addSubview:scrollView];
    [reusableView addSubview:pageControl];
    //  self.view.backgroundColor = [UIColor redColor];
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        // make.size.mas_equalTo(CGSizeMake(90, 90));
//        //make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
//        
//        make.top.equalTo(reusableView).with.offset(0);
//        
//        make.left.equalTo(reusableView).with.offset(0);
//        make.bottom.equalTo(reusableView).with.offset(0);
//        
//        make.right.equalTo(reusableView).with.offset(0);
//        
//        //make.size.mas_equalTo(CGSizeMake(HYKScreenW, HYKScreenH-108));
//        
//    }];
    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//
    NSArray *imageNames = @[@"welcome1", @"welcome2",@"welcome3",@"welcome4",];
    for (int i = 0; i < imageNames.count; i ++) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNames[i]]];
        iv.frame = CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:iv];
        iv.userInteractionEnabled = YES;
    
        UIButton * button=[[UIButton alloc]init];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+2;
        button.frame = CGRectMake(0, 0, iv.size.width, iv.size.height);
        
        [iv addSubview:button];
        
//        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//            // make.size.mas_equalTo(CGSizeMake(90, 90));
//            //make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
//            
//            make.top.equalTo(scrollView).with.offset(0);
//            
//            make.left.equalTo(scrollView).with.offset(0);
//            make.bottom.equalTo(scrollView).with.offset(0);
//            
//            make.right.equalTo(scrollView).with.offset(0);
//            
//            //make.size.mas_equalTo(CGSizeMake(HYKScreenW, HYKScreenH-108));
//            
//        }];
        

    }
    scrollView.contentSize =CGSizeMake(scrollView.frame.size.width*imageNames.count, 0);
    
    //翻页形式
    scrollView.pagingEnabled = YES;
    pageControl.numberOfPages = imageNames.count;

    
}
-(void)click:(UIButton*)gr{
    
    //UIImageView * imagView =(UIImageView *)[self.view  subviews];
    if (gr.tag ==2) {
        NSLog(@"2");
    }else if (gr.tag==3){
        NSLog(@"3");
    }else if (gr.tag==4){
        NSLog(@"4");
    }else if (gr.tag==5){
        NSLog(@"5");
    }
    
    
    
    NSLog(@"ddd");
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag==101) {
    CGPoint point = scrollView.contentOffset;
    NSInteger index = round(point.x/scrollView.frame.size.width);
    _pageControl.currentPage = index;
    }
    UIPanGestureRecognizer * gang =  scrollView.panGestureRecognizer;
  CGFloat y=  [gang translationInView:scrollView].y;
    if (y<-5) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else if (y>5){
        
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}
#pragma mark - 头视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.bounds.size.width, 180);
    
}
#pragma mark - UICollectionView Delegate DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.muphoto.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell * cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    cell.layer.cornerRadius =20;
    cell.backgroundColor =[UIColor yellowColor];
    UILabel * lablae=[[UILabel alloc]init];
    lablae.text =self.muphoto [indexPath.row];
    [lablae setFont:[UIFont systemFontOfSize:14]];
    lablae.frame= CGRectMake(0, 10, 80, 40);
    [cell.contentView addSubview:lablae];
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.muphoto removeObjectAtIndex:indexPath.row];
    
    [self.collectionView reloadData];
    NSLog(@" %@",self.muphoto[indexPath.row]);
    
    NSLog(@"%ld",(long)indexPath.row);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
