//
//  HYLeftView.h
//  HYfarme
//
//  Created by bidiao on 16/3/2.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYLeftView;
@protocol HYLeftViewDelegate <NSObject>

-(void)leftMenu:(HYLeftView*)menu didSelectedButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger )toIndex;

@end
@interface HYLeftView : UIView
@property(nonatomic,weak) id<HYLeftViewDelegate> delegatem;
@end
