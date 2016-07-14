//
//  EditViewController.h
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate>{
    NSString *editBookTitle;
    NSString *editImageUrl;
    NSString *editBookDate;
    NSString *editPrice;
    NSDate *editPurchaseDate;
    
}
//テキストフィールドの初期値
@property (nonatomic, copy) NSString *selectedTitle;
@property (nonatomic, copy) NSString *selectedPrice;
@property (nonatomic, copy) NSString *selectedDate;
@property (nonatomic, copy) NSString *selectedId;
@end
