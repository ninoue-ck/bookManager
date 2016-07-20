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
    self.adressField.placeholder =@"メールアドレスを入力してください";
    self.passField.placeholder =@"パスワードを入力してください";
    self.confirmPassField.placeholder =@"もう一度パスワードを入力してください";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)editAccount {
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
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error : %@", error);
          }
     ];
}

- (IBAction)saveAccount:(id)sender {
    if (![self.passField.text isEqualToString:self.confirmPassField.text ]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:@"パスワードが一致しません" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"再入力"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if([self.adressField.text length] == 0 || [self.passField.text length] == 0 || [self.confirmPassField.text length] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:@"入力されていない項目があります" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"再入力"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else {
        [self editAccount];
    }
}

- (IBAction)close_button:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) keyboardWillShow:(NSNotification *) notification {
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -70);
        self.view.transform = transform;
    } completion:NULL];
}

//消えた時に画面の位置を戻す
-(void) keyboardWillHide:(NSNotification *)notification {
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
- (IBAction)returnMail:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)returnPass:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)returnConfPass:(id)sender {
    [sender resignFirstResponder];
}
@end
