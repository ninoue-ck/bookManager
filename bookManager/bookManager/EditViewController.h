//
//  EditViewController.h
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate>{
    
    NSString *editBook_title;
    NSString *editImage_url;
    NSString *editBookDate;
    NSString *editPrice;
    NSDate *editPurchaseDate;
    
}


/*{
    NSString *selected_title;
    NSString *selected_price;
    NSString *selected_date;
    NSString *selected_id;
}*/

//テキストフィールドの初期値
//実行ファイルにするとインポートしてないからエラー出る
@property (nonatomic, copy) NSString *selected_title;
@property (nonatomic, copy) NSString *selected_price;
@property (nonatomic, copy) NSString *selected_date;
@property (nonatomic, copy) NSString *selected_id;
@end
