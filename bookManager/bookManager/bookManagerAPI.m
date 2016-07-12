//
//  bookManagerAPI.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/06.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//APIのjsonを取得してそれをarrayにするためのクラス
//http://qiita.com/asakahara/items/9cb68bef56ca70b505c6


#import "bookManagerAPI.h"
#import <AFNetworking/AFNetworking.h>

@interface bookManagerAPI()
@end

@implementation bookManagerAPI

//- (戻り値の型)メソッド名:(引数の型)引数名 {
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
              //  NSLog(@"回数は%d", API_Array.count);

              _ID_Array = [[NSMutableArray alloc]init];
              _Image_Array = [NSMutableArray array];
              _Title_Array = [NSMutableArray array];
              _Price_Array = [NSMutableArray array];
              _Date_Array = [NSMutableArray array];
              
              // NSLog(@"response: %@", responseObject);
              //  NSLog(@"%@",API_Array);
              
              //取得したAPIをそれぞれの配列に格納
              NSLog(@"%@",API_Array);
              for(int i = 0; i < API_Array.count; i++) {
                  [_ID_Array addObject:[API_Array[i] objectForKey:@"id"]];
                  [_Image_Array addObject:[API_Array[i] objectForKey:@"image_url"]];
                  [_Title_Array addObject:[API_Array[i] objectForKey:@"name"]];
                  [_Price_Array addObject:[API_Array[i] objectForKey:@"price"]];
                  [_Date_Array addObject:[API_Array[i] objectForKey:@"purchase_date"]];
                  //NSLog(@"%@",[API_Array[i] objectForKey:@"id"]);
              }
              NSLog(@"%@",_Price_Array);
              NSLog(@"%@",_Title_Array);
              NSLog(@"%@",_Date_Array);
              //   NSLog(@"%@", name);
              
          } failure:^(NSURLSessionDataTask *operation, NSError *error) {
              // エラーの場合はエラーの内容をコンソールに出力する
              NSLog(@"failed: %@", error);
          }];
    // Do any additional setup after loading the view.
    //  NSLog(@"%@",_Price_Array);
    
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
