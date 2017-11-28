//
//  HYTitleView.m
//  HYfarme
//
//  Created by bidiao on 16/3/2.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import "HYTitleView.h"

@implementation HYTitleView

-(id)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self setImage:[UIImage imageNamed:@"navbar_netease" ] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        self.titleLabel.font = [UIFont systemFontOfSize:23];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
       // self.titleLabel.numberOfLines =0;
        self.height = self.currentImage.size.height;
    }
    
    
    return self;
}
-(void)setTitle:(NSString *)title{
    
    
    _title =[title copy];
    [self setTitle:title forState:UIControlStateNormal];
    NSDictionary *attrs =@{NSFontAttributeName:self.titleLabel.font};
    CGFloat titeW =[title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    self.width = titeW+self.titleEdgeInsets.left+self.currentImage.size.width+40;
    
    
    
}
@end
