//
//  bookManagerAPI.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/06.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//APIのjsonを取得してそれをarrayにするためのクラス


#import "bookManagerAPI.h"
#import <AFNetworking/AFNetworking.h>

@interface bookManagerAPI()
//APIを入れる配列たち
@property (nonatomic) NSMutableArray *booktitle_Array;
@property (nonatomic) NSMutableArray *bookprice_Array;
@property (nonatomic) NSMutableArray *bookdate_Array;

@end


@implementation bookManagerAPI
//配列たちの初期化
- (id)init {
    _booktitle_Array  = [NSMutableArray array];
    _bookprice_Array  = [NSMutableArray array];
    _bookdate_Array    = [NSMutableArray array];
    
    return self;
}




/*
 NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:origin]];
// サーバーとの通信を行う
NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
// JSONをパース
NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];

//NSLogで表示
NSLog(@"名前:%@ 誕生日:%@", [array valueForKeyPath:@"name"], [array valueForKeyPath:@"birthday"]);
*/
@end
