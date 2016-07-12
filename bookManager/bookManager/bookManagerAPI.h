//
//  bookManagerAPI.h
//  bookManager
//
//  Created by inouenaoto on 2016/07/06.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//APIのjsonを取得してそれをarrayにするためのクラス


#import <Foundation/Foundation.h>

@interface bookManagerAPI : NSObject


@property (nonatomic) NSMutableArray *ID_Array;
@property (nonatomic) NSMutableArray *Image_Array;
@property (nonatomic) NSMutableArray *Price_Array;
@property (nonatomic) NSMutableArray *Title_Array;
@property (nonatomic) NSMutableArray *Date_Array;

- (void)GetJson;

@end
