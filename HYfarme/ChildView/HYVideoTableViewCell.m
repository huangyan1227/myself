//
//  HYVideoTableViewCell.m
//  HYfarme
//
//  Created by bidiao on 16/12/2.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "HYVideoTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
@implementation HYVideoTableViewCell
{
    UIButton * _view0;
    UIView * _view1;
    UILabel * _lableview2;
    UILabel * _lableview3;
    UIView * _view4;
    UIView * _view5;
    
    
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton * view0 = [UIButton new];
        
        view0.tag = 1;
        
        _view0 = view0;
        
        view0.backgroundColor = [UIColor redColor];
        
        [view0  addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * view1 = [UIView new];
        
        view1.tag = 2;
        

        view1.backgroundColor = [UIColor  yellowColor];
        
        _view1 = view1;
        
        UILabel * view2 = [UILabel new];
        
        view1.tag = 3;
        

        view2.backgroundColor = [UIColor orangeColor];
        
        _lableview2 = view2;
        
        UILabel * lableView3= [UILabel new];
        
        lableView3.tag = 4;
        

        lableView3.backgroundColor = [UIColor greenColor];
        
        _lableview3 = lableView3;
        
        UIView * view4 = [UIView new];
        
         view4.tag = 5;
        

        view4.backgroundColor = [UIColor grayColor];
        
        _view4 = view4;
        
        UIView * view5 = [UIView new];
        
        view5.tag = 6;
        

        view5.backgroundColor = [UIColor blueColor];
        
        _view5 = view5;
        
        [self.contentView sd_addSubviews:@[view0,view1,view2,lableView3,view4,view5]];
        
        _view0.sd_layout.widthIs(50).heightIs(50).topSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,10);
        
        _view1.sd_layout.topEqualToView(_view0).leftSpaceToView(_view0,10).rightSpaceToView(self.contentView,10).heightRatioToView(_view0,0.4);
        
        _lableview2.sd_layout
        .topSpaceToView(_view1, 10)
        .rightSpaceToView(self.contentView, 60)
        .leftEqualToView(_view1)
        .autoHeightRatio(0);
        
        _lableview3.sd_layout
        .topEqualToView(_lableview2)
        .leftSpaceToView(_lableview2, 10)
        .heightRatioToView(_lableview2, 1)
        .rightEqualToView(_view1);
        
        _view4.sd_layout
        .leftEqualToView(_lableview2)
        .topSpaceToView(_lableview2, 10)
        .heightIs(30)
        .widthRatioToView(_view1, 0.7);
        
        _view5.sd_layout
        .leftSpaceToView(_view4, 10)
        .rightSpaceToView(self.contentView, 10)
        .bottomSpaceToView(self.contentView, 10)
        .heightRatioToView(_view4, 1);
        
        
        [self setupAutoHeightWithBottomView:_view4 bottomMargin:50];
        
        
        
        
    }
    
    
    
    return self;
    
    
}
-(void)click{
    
     NSLog(@"dd");
    
}

-(void)setText:(NSString *)text{
    
    
    _text =text;
    _lableview2.text =text;
    
}
-(void)setTextColor:(UIColor *)textColor{
    
    _textColor =textColor;
    _lableview2.textColor =textColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
