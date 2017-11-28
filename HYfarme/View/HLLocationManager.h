//
//  HLLocationManager.h
//  HYfarme
//
//  Created by bidiao on 16/12/6.
//  Copyright © 2016年 bidiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


#define single_interface(class)  + (class *)shared##class;

// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define single_implementation(class) \
static class *_instance; \
\
+ (class *)shared##class \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}

/**
 *  定位block块
 *
 *  @param location  当前位置对象
 *  @param placeMark 反地理编码对象
 *  @param error     错误信息
 */
typedef void(^ResultLocationInfoBlock)(CLLocation *location, CLPlacemark *placeMark, NSString *error);

/**
 *  定位block块(仅获取经纬度坐标)
 *
 *  @param location  当前位置对象
 *  @param error     错误信息
 */
typedef void(^ResultLocationBlock)(CLLocation *location);





@interface HLLocationManager : NSObject










//单例对象
single_interface(HLLocationManager)


/**
 *  直接通过代码块获取用户位置信息
 *
 *  @param block 定位block代码块
 */
-(void)getCurrentLocation:(ResultLocationInfoBlock)block onViewController:(UIViewController *)viewController;

/**
 *  直接通过代码块获取用户位置信息
 *
 *  @param block 定位block代码块
 */
//-(void)getCurrentLocationOnly:(ResultLocationBlock)block onViewController:(UIViewController *)viewController;

@end
