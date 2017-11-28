//
//  AppDelegate.m
//  HYfarme
//
//  Created by bidiao on 15/12/2.
//  Copyright © 2015年 bidiao. All rights reserved.
//

#import "AppDelegate.h"
#import "HYMainViewController.h"
#import "HYMYfirstViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "HYAddViewController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
   
    UIApplicationShortcutIcon * icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_discover_selected"];
    
    UIApplicationShortcutIcon * icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_home_selected"];
    
    
    UIMutableApplicationShortcutItem * itme1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.depp1" localizedTitle:@"名字自己起1" localizedSubtitle:@"Launch 1" icon:icon1 userInfo:nil];
    
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.deep2" localizedTitle:@"名字自己起2" localizedSubtitle:@"Launch 2nd Level" icon:icon2 userInfo:nil];
    
    NSArray *items = @[itme1,item2];
    
    application.shortcutItems = items;
    
    
    
    //注册通知
    
    if ([UIDevice currentDevice].systemName.floatValue>9.0) {
        
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    
                }];
            }
            
        }];
        
        center.delegate = self;
        
    }else{
        
        UIUserNotificationSettings * s = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
        
        [application registerUserNotificationSettings:s];
        
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =[UIColor whiteColor];
    self.window.rootViewController =[HYMYfirstViewController new];

    
    [self.window  makeKeyWindow];
    
    
    return YES;
}

//注册成功返回DecviceToken
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString * dectoken =[NSString stringWithFormat:@"%@",deviceToken];
    
    NSMutableString * st = [NSMutableString stringWithString: dectoken];
    
    [st deleteCharactersInRange:NSMakeRange(0, 1)];
    
    [st deleteCharactersInRange:NSMakeRange(st.length - 1, 1)];
    
    NSString * string = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults * u = [NSUserDefaults standardUserDefaults];
                          
     [u  setObject:string forKey:@"deviceToken"];
    
    //存入沙盒
    [u synchronize];

}
//注册失败
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
   
    NSLog(@"注册失败 %@",error);
}
//接受到推送消息
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    // NSDictionary * userInfo = notification.request.content.userInfo;
    //    UNNotificationRequest *request = notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    
    
    NSLog(@"前台接受消息");
    
    completionHandler(UNNotificationPresentationOptionAlert);
    
    
    
}
//接受到推送通知后台点击
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    //  UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    //  UNNotificationContent *content = request.content; // 收到推送的消息内容
    // NSNumber *badge = content.badge;  // 推送消息的角标
    // NSString *body = content.body;    // 推送消息体
    // UNNotificationSound *sound = content.sound;  // 推送消息的声音
    // NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //  NSString *title = content.title;  // 推送消息的标题
    
    NSInteger badgec = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    if (badgec>=0) {
        
        badgec--;
        
        [UIApplication sharedApplication].applicationIconBadgeNumber=badgec;
        
        
    }
    
    
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
      //  [self showmessage:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        
    }
    else {
        // 判断为本地通知
        //        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    
    completionHandler();
    
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    NSLog(@"gh");
    if([shortcutItem.type isEqualToString:@"com.test.depp1"]){
        NSLog(@" com.test.depp1");
        printf("com.test");
        
        [self.window.rootViewController  presentViewController:[HYAddViewController new] animated:YES completion:nil];
        //自己要做的事情
        
    }else if ([shortcutItem.type isEqualToString:@"com.test.deep2"]){
        
         NSLog(@" com.test.deep2");
        //自己要做的事情
    }
    
    
    
    
}
    

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
