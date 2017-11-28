//
//  Constants.h
//  HYfarme
//
//  Created by bidiao on 15/12/3.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define HYRandomColor  [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:(arc4random_uniform(256))/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]

#define HYColorRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define HYKScreenW [UIScreen mainScreen].bounds.size.width
#define HYKScreenH [UIScreen mainScreen].bounds.size.height
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//方正黑体简体字体定义

#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
#endif /* Constants_h */
