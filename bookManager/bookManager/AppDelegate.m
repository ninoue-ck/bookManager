//
//  AppDelegate.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountViewController.h"
#import "AccountSettingViewController.h"


@interface AppDelegate (){
    UITabBarController *tabBarController;
}

@end

@implementation AppDelegate

@synthesize window;

//初回起動かどうかの判定
- (BOOL)isFirstRun{
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
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if  ([self isFirstRun ]){
        // 初回起動時の処理
        // Storyboard を呼ぶ
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        // Storyboard の中のどの ViewContorller を呼ぶか
        // @""の中は Storyboard IDを記述する。
        AccountSettingViewController* vc = [storyboard instantiateViewControllerWithIdentifier: @"AccountSettingViewController"];
        // その画面を表示させる
        [self.window setRootViewController:vc];
        
    }
    //タブの文字設定
    UIFont *tabFont = [UIFont fontWithName:@"ArialMT" size:17.0f];
    NSDictionary *selectedAttributes = @{NSFontAttributeName:tabFont,NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    NSDictionary *attributesNomal = @{NSFontAttributeName:tabFont,NSForegroundColorAttributeName:[UIColor grayColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:attributesNomal forState:UIControlStateNormal];
    
    //タブの画像設定
    UIImage *image1 = [UIImage imageNamed:@"tab.jpg"];
    UIImage *image2= [UIImage imageNamed:@"selected_tub.jpg"];
    [[UITabBar appearance] setBackgroundImage:image1];
    [[UITabBar appearance] setSelectionIndicatorImage:image2];
    return YES;
}

@end
