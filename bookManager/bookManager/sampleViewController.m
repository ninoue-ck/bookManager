//
//  sampleViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/07.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//http://qiita.com/asakahara/items/9cb68bef56ca70b505c6

#import "sampleViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface sampleViewController ()
@property (nonatomic) NSMutableArray *ID_Array;
@property (nonatomic) NSMutableArray *Image_Array;
@property (nonatomic) NSMutableArray *Price_Array;
@property (nonatomic) NSMutableArray *Title_Array;
@property (nonatomic) NSMutableArray *Date_Array;

@end

@implementation sampleViewController




- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(id)sender {
     NSLog(@"%@",_Price_Array);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
