//
//  AppDelegate.h
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIWindow *window;
    UITabBarController *TabBarController;
}

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookimageView;

@end

