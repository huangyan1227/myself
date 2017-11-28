//
//  HYLeftView.m
//  HYfarme
//
//  Created by bidiao on 16/3/2.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "HYLeftView.h"
#import "HYLeftButton.h"

@interface HYLeftView()
@property(nonatomic,weak) HYLeftButton * selectedButton;
@end
@implementation HYLeftView

-(id)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        
        CGFloat alpha = 0.2;
        [self setupBtnWithIcon:@"sidebar_nav_news" title:@"新e闻" bgColor:HYColorRGB(202, 68, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_reading" title:@"订阅" bgColor:HYColorRGB(202, 68, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_photo" title:@"图片" bgColor:HYColorRGB(76, 132, 190, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_video" title:@"视频" bgColor:HYColorRGB(101, 170, 78, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_comment" title:@"跟帖" bgColor:HYColorRGB(170, 172, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_radio" title:@"电台" bgColor:HYColorRGB(190, 62, 119, alpha)];
    }
   
    
    return self;
    
    
}

-(HYLeftButton*)setupBtnWithIcon:(NSString *)icon title:(NSString *)title bgColor:(UIColor*)bgColor{
    HYLeftButton *btn =[[HYLeftButton alloc]init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    //设置文字
    [btn setImage:[UIImage imageNamed: icon ] forState:UIControlStateNormal ];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    // 设置按钮选中的背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
    

}
-(void)setDelegatem:(id<HYLeftViewDelegate>)delegatem{
    
    _delegatem =delegatem;
    [self buttonClick:[self.subviews firstObject]];
    
}
-(void)layoutSubviews{
    
    NSUInteger btnCount =self.subviews.count;
    CGFloat btnW =self.width;
    CGFloat btnH = self.height / btnCount;
    for (int i = 0; i<btnCount; i++) {
        HYLeftButton *btn =self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y =i*btnH;
    }
    
}
-(void)buttonClick:(HYLeftButton *)button{
    
    if ([self.delegatem respondsToSelector:@selector(leftMenu:didSelectedButtonFromIndex:toIndex:)]) {
        [self.delegatem leftMenu:self didSelectedButtonFromIndex:(int)self.selectedButton.tag toIndex:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton =button;
}



@end
