//
//  API_ExchengeViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/07.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "API_ExchengeViewController.h"

@interface API_ExchengeViewController ()
//jsonを入れる配列たち
@property (nonatomic) NSMutableArray *booktitle_Array;
@property (nonatomic) NSMutableArray *bookprice_Array;
@property (nonatomic) NSMutableArray *bookdate_Array;


@end

@implementation API_ExchengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // データの取得（ネット）on sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *re
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//配列にjsonを入れていく
- (void)getJSON
{
    NSURL *url = [NSURL URLWithString:@"http://app.com/book/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        // データの配列をプロパティに保持
        self.booktitle_Array = [[jsonDictionary objectForKey:@"result"] objectForKey:@"name"];
        self.bookprice_Array = [[jsonDictionary objectForKey:@"result"] objectForKey:@"price"];
        self.bookdate_Array = [[jsonDictionary objectForKey:@"result"] objectForKey:@"purchase_dare"];
    }];
    for(id s in _booktitle_Array)
    {
        NSLog(@"%@",(NSString*)s);
    }
    NSLog(@"result %@",_booktitle_Array);
}

//追加できてるか確認


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
