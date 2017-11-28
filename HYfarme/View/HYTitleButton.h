//
//  HYTitleButton.h
//  HYfarme
//
//  Created by bidiao on 15/12/3.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTitleButton;
@protocol HYTitleButtonDelegate <NSObject>
-(void)hyTitleButton:(HYTitleButton *)titleButton dedSelectButtonIndex:(NSInteger)index;


@end
@interface HYTitleButton : UIView
@property(nonatomic,weak) id<HYTitleButtonDelegate>delegatehy;
@end
