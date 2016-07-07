//
//  sampleViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/07.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

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
              NSLog(@"%@",_Price_Array);
              NSLog(@"  1: %@",_Title_Array[1]);
              
              //   NSLog(@"%@", name);
              
          } failure:^(NSURLSessionDataTask *operation, NSError *error) {
              // エラーの場合はエラーの内容をコンソールに出力する
              NSLog(@"failed: %@", error);
          }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
