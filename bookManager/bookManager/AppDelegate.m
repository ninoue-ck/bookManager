//
//  AppDelegate.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountViewController.h"



@interface AppDelegate (){
        UITabBarController *tabBarController;
}

@end

@implementation AppDelegate






/*
//初回起動かどうかの判定
- (BOOL)isFirstRun
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"firstRunDate"]) {
        // 日時が設定済みなら初回起動でない
        return NO;
    }
    
    // 初回起動日時を設定
    [userDefaults setObject:[NSDate date] forKey:@"firstRunDate"];
    
    // 保存
    [userDefaults synchronize];
    
    // 初回起動
    return YES;
}


//初回起動ならアカウント設定
*/



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
    //タブの文字設定
    UIFont *tabFont = [UIFont fontWithName:@"ArialMT" size:17.0f];
    NSDictionary *selectedAttributes = @{NSFontAttributeName:tabFont,NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected
     ];
    NSDictionary *attributesNomal = @{NSFontAttributeName:tabFont,NSForegroundColorAttributeName:[UIColor grayColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:attributesNomal forState:UIControlStateNormal];
    
    //タブの画像設定
    UIImage *image1 = [UIImage imageNamed:@"tabbar_item.png"];
//ひとまず一色で  UIImage *image2= [UIImage imageNamed:@"tab_bar_selected.jpg"];
    [[UITabBar appearance] setBackgroundImage:image1];
//    [[UITabBar appearance] setSelectionIndicatorImage:image2];
    return YES;
    
    
/*    if ([self isFirstRun]) {
        // 初回起動時の処理
        // Storyboard を呼ぶ
        UIStoryboard *TutorialSB = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        // Storyboard の中のどの ViewContorller を呼ぶか
        // @""の中は Storyboard IDを記述する。ココ間違えばブラック画面かな。
        AccountViewController* vc = [TutorialSB instantiateViewControllerWithIdentifier: @"AccountViewController"];
        // その画面を表示させる
        [self.window setRootViewController:vc];
    }

//タブの設定
    UIImage *image1= [UIImage imageNamed:@"tabbaritem.png"];
    UIImage *image2= [UIImage imageNamed:@"tabbar_selected.png"];
    [[UITabBar appearance] setBackgroundImage:image1];
    [[UITabBar appearance] setSelectionIndicatorImage:image2];
    return YES;
*/
 
}













/*- (BOOL):(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
*/
 
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
