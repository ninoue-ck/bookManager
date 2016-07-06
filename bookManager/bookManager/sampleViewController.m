//
//  sampleViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/06.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "sampleViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface sampleViewController ()

@end

@implementation sampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error0 = nil;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"local" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error: &error0];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    if(error0){NSLog(@"よみこみえらー");}
    
    //------------------------------
    // NSArray に変換
    //------------------------------
    NSError *error1 = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&error1];
    if(error1){NSLog(@"ぱーすえらー");}
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
