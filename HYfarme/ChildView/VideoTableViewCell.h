//
//  VideoTableViewCell.h
//  HYfarme
//
//  Created by bidiao on 16/12/9.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoMode.h"

@class VideoTableViewCell;

@protocol VideoDelegate <NSObject>

- (void)PlayVideoWithCell:(VideoTableViewCell *)cell;

@end

@interface VideoTableViewCell : UITableViewCell


/**model*/

@property (nonatomic,copy) VideoMode *model;

@property (nonatomic,weak) id <VideoDelegate>videoDelegate;


- (CGFloat)cellOffset;

@end
