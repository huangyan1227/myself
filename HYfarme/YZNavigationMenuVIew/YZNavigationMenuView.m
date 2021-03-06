//
//  YZNavigationMenuView.m
//  YZNavigationMenuView
//
//  Created by holden on 2016/12/25.
//  Copyright © 2016年 holden. All rights reserved.
//

#import "YZNavigationMenuView.h"

@interface YZNavigationMenuView ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, strong) UIView *shapeView;

@end

@implementation YZNavigationMenuView

- (void)setImageArray:(NSArray *)imageArray
{
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (id obj in imageArray) {
        if ([obj isKindOfClass:[NSString class]]) {
            UIImage *image = [UIImage imageNamed:obj];
            [mutArray addObject:image];
        }else if ([obj isKindOfClass:[UIImage class]]) {
            [mutArray addObject:obj];
        }
    }
    _imageArray = mutArray;
}

- (instancetype)initWithPositionOfDirection:(CGPoint)point images:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _point = point;
        
        _shapeView = [[UIView alloc] init];
       // _shapeView.backgroundColor = [UIColor yellowColor];
        _shapeView.center = CGPointMake(point.x, point.y + 5);
        _shapeView.bounds = CGRectMake(0, 0, 12, 8);
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.position = CGPointMake(6, 4);
        shapeLayer.bounds = CGRectMake(0, 0, 12, 8);
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        [_shapeView.layer addSublayer:shapeLayer];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(6, 0)];
        [bezierPath addLineToPoint:CGPointMake(0, 8)];
        [bezierPath addLineToPoint:CGPointMake(12, 8)];
        [bezierPath addLineToPoint:CGPointMake(6, 0)];
        shapeLayer.path = bezierPath.CGPath;
        
        _titleArray = titleArray;
        self.imageArray = imageArray;
        
        NSInteger maxLenght = 0;
        for (NSString *title in _titleArray) {
            if (title.length > maxLenght) {
                maxLenght = title.length;
            }
        }
        CGFloat tableViewW = maxLenght * 16.5 + 74;
        CGFloat tableViewX = 0.0f;
        CGFloat tableViewH = _titleArray.count * 44;
        if (point.x < self.frame.size.width/2) {
            if (point.x > tableViewW - 8) {
                tableViewX = point.x - tableViewW + 12;
            }else {
                tableViewX = 4;
            }
        }else {
            if (self.frame.size.width - point.x > tableViewW - 8) {
                tableViewX = point.x - 12;
            }else {
                tableViewX = self.frame.size.width - tableViewW - 4;
            }
        }
        BOOL scrollEnabled = NO;
        if (self.frame.size.height - point.y - 15 < tableViewH) {
            tableViewH = self.frame.size.height - point.y - 15;
            scrollEnabled = YES;
        }
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, point.y + 8, tableViewW, tableViewH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 4;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.scrollEnabled = scrollEnabled;
        [self addSubview:_tableView];

    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    cell.imageView.image = [_imageArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    if (_clickedBlock) {
        _clickedBlock(indexPath.row);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(navigationMenuView:clickedAtIndex:)]) {
        [_delegate navigationMenuView:self clickedAtIndex:indexPath.row];
    }
    //消失
    [self viewTableDisappear];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self viewTableDisappear];
}
-(void)viewTableDisappear{
    
    [UIView animateWithDuration:.2f animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        _tableView.alpha = 0.0f;
        _shapeView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [_shapeView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
    
    
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview
{
    
    NSLog(@"开始MoveToSuperview");
    [super willMoveToSuperview:newSuperview];
   
    if (newSuperview) {
        CGRect tableViewFrame = _tableView.frame;

       UIViewController *nextResponder = (UIViewController *)[newSuperview nextResponder];
        if (!_shapeView.superview && [nextResponder isKindOfClass:[UIViewController class]]) {
            if (nextResponder.navigationController && _shapeView.frame.origin.y < 64) {
                
                [nextResponder.navigationController.view addSubview:_shapeView];
                tableViewFrame.origin.y = 64;
                _tableView.frame = tableViewFrame;

            }else {
                [self addSubview:_shapeView];
            }
        }
        
        _tableView.layer.anchorPoint = CGPointMake((_point.x - tableViewFrame.origin.x)/tableViewFrame.size.width, 0);
        _tableView.center = CGPointMake(_point.x, _point.y + 8);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _tableView.alpha = 0.0f;
        _shapeView.alpha = 0.0f;
        _tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
        [UIView animateWithDuration:.2f animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
            _tableView.transform = CGAffineTransformMakeScale(1, 1);
            _tableView.alpha = 1.0f;
            _shapeView.alpha = 1.0f;
            
        }];

    }

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
