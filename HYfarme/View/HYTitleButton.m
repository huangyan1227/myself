//
//  HYTitleButton.m
//  HYfarme
//
//  Created by bidiao on 15/12/3.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "HYTitleButton.h"


@interface HYTitleButton()
@property(nonatomic,weak) UIButton *selectbutton;

@end
@implementation HYTitleButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
       //第一button
        [self butttonName];
        //第二个button
        [self butttonName];
       
    }
    return self;
}
-(void)butttonName {
    
    UIButton * button=[[UIButton alloc]init];
    button.tag =self.subviews.count;
    button.backgroundColor =[UIColor yellowColor];
    [button setBackgroundImage:[UIImage imageWithColor:HYRandomColor] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
-(void)buttonClick:(UIButton *)button{
    
    if ([self.delegatehy respondsToSelector:@selector(hyTitleButton:dedSelectButtonIndex:)]) {
        [self.delegatehy hyTitleButton:self dedSelectButtonIndex:button.tag];
    }
    
    self.selectbutton.selected = NO;
    button.selected= YES;
    self.selectbutton =button;
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger btnCount =self.subviews.count;
    CGFloat btnW =self.width/btnCount;
    CGFloat btnH = self.height;
    for (int i=0; i<btnCount; i++) {
        UIButton *button =self.subviews[i];
        button.height=btnH;
        button.width=btnW;
        button.x=i*btnW;
    }
}
@end
