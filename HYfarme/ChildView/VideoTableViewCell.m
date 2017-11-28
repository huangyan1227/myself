//
//  VideoTableViewCell.m
//  HYfarme
//
//  Created by bidiao on 16/12/9.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "VideoTableViewCell.h"

#import "UIView+CLSetRect.h"

#import "UIImage+CLTintColor.h"

#import "UIImageView+WebCache.h"


@interface VideoTableViewCell ()

/**button*/
@property (nonatomic,weak) UIButton *button;
/**picture*/
@property (nonatomic,weak) UIImageView *PictureView;

@end

#define CellHeight   400


@implementation VideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
    }
    
    
    
    return self;
}
-(void)initUI{
    //裁剪看不到的
    NSLog(@"INITUI");
    self.clipsToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView * pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -CellHeight/2.0, CLscreenWidth, 20)];
    
    [self.contentView addSubview:pictureView];
    
    pictureView.tag =  1;
    _PictureView = pictureView;
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    button.tag =2;
    [button setBackgroundImage:[[self getPictureWithName:@"CLPlayBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    _button = button;
    
  
    
    
}
-(void)setModel:(VideoMode *)model{
    
    
    _model = model;
    
    //[_PictureView sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl]];
    [_PictureView sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:[UIImage imageNamed:@"promoboard_icon_mall"]];
}
-(UIImage*)getPictureWithName:(NSString*)name{
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CLPlayer" ofType:@"bundle"]];
    
    NSString *path   = [bundle pathForResource:name ofType:@"png"];
  
    return [UIImage imageWithContentsOfFile:path];
    
}
-(void)playAction:(UIButton*)button{
    
    if (_videoDelegate && [_videoDelegate respondsToSelector:@selector(PlayVideoWithCell:)]) {
        [_videoDelegate PlayVideoWithCell:self];
    }
    
    
    
}
-(CGFloat)cellOffset{
    
    /*
     - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
     将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
     这里用来获取self在window上的位置
     */
    CGRect toWindow = [self convertRect:self.bounds toView:self.window];
    
    //获取父视图的中心
    CGPoint windowCenter = self.superview.center;
    
    //cell在y轴上的位移  CGRectGetMidY之前讲过,获取中心Y值
    CGFloat cellOffsetY = CGRectGetMidY(toWindow) - windowCenter.y;
    
    //位移比例
    CGFloat offsetDig = 2 * cellOffsetY / self.superview.frame.size.height ;
    
    
    //要补偿的位移,self.superview.frame.origin.y是tableView的Y值，这里加上是为了让图片从最上面开始显示
    CGFloat superViewY = CLscreenHeight - self.superview.frame.size.height;
    CGFloat offset = -offsetDig * CellHeight / 2 + superViewY;
    
    //让pictureViewY轴方向位移offset
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    _PictureView.transform = transY;
    
    return offset;
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _button.CLcenterX = self.CLwidth/2.0;
    _button.CLcenterY = self.CLheight/2.0;
    
    _PictureView.CLheight = self.CLheight * 2;
    
      [self cellOffset];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
