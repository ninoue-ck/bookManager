//
//  AccountViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/03.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//

#import "AccountViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account_adress;
@property (weak, nonatomic) IBOutlet UITextField *account_pass;
@property (weak, nonatomic) IBOutlet UITextField *account_confirm_pass;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)accountLogin {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString *url = @"http://app.com/account/login";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{@"mail_address" : _account_adress.text,
               @"password" : _account_pass.text,
               };
    NSLog(@"%@", params);
    
    [manager POST:url
       parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSLog(@"%@", responseObject);
              
              [self tolisttableView];
              
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error : %@", error);
              
              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"メールアドレスかパスワードどちらかが間違っています" preferredStyle:UIAlertControllerStyleAlert];
              
              [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                  [self alertbutton];
              }]];
              
              [self presentViewController:alertController animated:YES completion:nil];
          }];
}
-(void)alertbutton{
    
}

- (void)tolisttableView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [self presentViewController:vc animated:YES completion:nil];
}

//モーダル閉じる
- (IBAction)account_close:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login_save:(id)sender {
    if ([_account_adress.text length] == 0  || [_account_pass.text length] == 0  || [_account_confirm_pass.text length] == 0)  {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"項目に誤りがあります" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self alertbutton];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [self accountLogin];
    }
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
