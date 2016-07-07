//
//  bookManagerAPI.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/06.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//APIのjsonを取得してそれをarrayにするためのクラス
// https://teratail.com/questions/10512


#import "bookManagerAPI.h"
#import <AFNetworking/AFNetworking.h>

@interface bookManagerAPI()

@property (nonatomic) NSMutableArray *ID_Array;
@property (nonatomic) NSMutableArray *Image_Array;
@property (nonatomic) NSMutableArray *Price_Array;
@property (nonatomic) NSMutableArray *Title_Array;
@property (nonatomic) NSMutableArray *Date_Array;

@end




@implementation bookManagerAPI

- (void)GetJson {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    NSString *url = @"http://app.com/book/get";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{@"page":@"0-10"};
    
    [manager POST:@"http://app.com/book/get"
       parameters:params
          success:^(NSURLSessionDataTask *operation, id responseObject) {
              //通信に成功した場合の処理
              NSArray *API_Array = [responseObject objectForKey:@"result"];
              
              NSMutableArray *id = [NSMutableArray array];
              NSMutableArray *image_url = [NSMutableArray array];
              NSMutableArray *name = [NSMutableArray array];
              NSMutableArray *price = [NSMutableArray array];
              NSMutableArray *purchase_date = [NSMutableArray array];
              
              // NSLog(@"response: %@", responseObject);
              //  NSLog(@"%@",API_Array);
              for(int i = 0; i < API_Array.count; i++) {
                  [_ID_Array addObject:[API_Array[i] objectForKey:@"id"]];
                  [_Image_Array addObject:[API_Array[i] objectForKey:@"image_url"]];
                  [_Title_Array addObject:[API_Array[i] objectForKey:@"name"]];
                  [_Price_Array addObject:[API_Array[i] objectForKey:@"price"]];
                  [_Date_Array addObject:[API_Array[i] objectForKey:@"purchase_date"]];
                  //NSLog(@"%@",[API_Array[i] objectForKey:@"id"]);
              }
              //    NSLog(@"%@",_bookPrice);
              //  NSLog(@"  1: %@",_bookTitle[1]);
              
              //   NSLog(@"%@", name);
              
          } failure:^(NSURLSessionDataTask *operation, NSError *error) {
              // エラーの場合はエラーの内容をコンソールに出力する
              NSLog(@"failed: %@", error);
          }];
    //  NSLog(@"%@",_bookPrice);
    // NSLog(@"  1: %@",_bookTitle[1]);
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
