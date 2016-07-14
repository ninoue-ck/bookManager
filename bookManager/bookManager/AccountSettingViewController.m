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
@property (weak, nonatomic) IBOutlet UITextField *adressField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassField;

@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _adressField.placeholder =@"メールアドレスを入力してください";
    _passField.placeholder =@"パスワードを入力してください";
    _confirmPassField.placeholder =@"もう一度パスワードを入力してください";
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
    params = @{@"mail_address" : _adressField.text,
               @"password" : _passField.text
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
    if (![_passField.text isEqualToString:_confirmPassField.text ]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"パスワードが一致しません" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"再入力" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self alertbutton];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else if
        ([_adressField.text length] == 0 || [_passField.text length] == 0 || [_confirmPassField.text length] == 0) {
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

-(void) keyboardWillShow:(NSNotification *) notification{
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -70);
        self.view.transform = transform;
    } completion:NULL];
}

//消えた時に画面の位置を戻す
-(void) keyboardWillHide:(NSNotification *)notification{
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
//キーボードを閉じる処理
- (IBAction)mail_return:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)pass_return:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)confpass_return:(id)sender {
    [sender resignFirstResponder];
}


@end
