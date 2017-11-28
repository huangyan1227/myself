//
//  HYTabBar.h
//  HYtabbar
//
//  Created by bidiao on 15/12/2.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTabBar;
@protocol HYTabBarDelegate <NSObject>


@optional
- (void)tabBarDidClickedPlusButton:(HYTabBar *)tabBar;

@end


@interface HYTabBar : UITabBar

//
//@property (nonatomic, weak) id<HYTabBarDelegate> delegatehy;

@property(nonatomic,weak) id<HYTabBarDelegate> delegatehy;
@end
