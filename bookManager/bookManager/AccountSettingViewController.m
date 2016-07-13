//
//  AccountRegistViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/12.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "AccountSettingViewController.h"
#import <AFNetworking/AFNetworking.h>



@interface AccountSettingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *adress_field;
@property (weak, nonatomic) IBOutlet UITextField *pass_field;
@property (weak, nonatomic) IBOutlet UITextField *confirm_pass_field;

@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _adress_field.placeholder =@"メールアドレスを入力してください";
    _pass_field.placeholder =@"パスワードを入力してください";
    _confirm_pass_field.placeholder =@"もう一度パスワードを入力してください";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Account_edit  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString *url = @"http://app.com/account/register";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{@"mail_address" : _adress_field.text,
               @"password" : _pass_field.text
               };
    NSLog(@"%@", params);
    
    [manager POST:url
       parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject) {
              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
              [defaults setObject:@"textMailAdress" forKey:@"mail_address"];
              [defaults setObject:@"textPassword" forKey:@"password"];
          }failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error : %@", error);
          }];
}

- (IBAction)Account_save:(id)sender {
    if (![_pass_field.text isEqualToString:_confirm_pass_field.text ]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"パスワードが一位しません" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"再入力" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self alertbutton];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else if
        ([_adress_field.text length] == 0 || [_pass_field.text length] == 0 || [_confirm_pass_field.text length] == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"入力されていない項目があります" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"再入力" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self alertbutton];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    else {
        [self Account_edit];
        [self dismissViewControllerAnimated:YES completion:nil];
        //    [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)close_button:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




-(void)alertbutton{
    
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
