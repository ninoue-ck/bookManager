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

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _account_adress.placeholder =@"メースアドレスを入力してください";
    _account_pass.placeholder =@"パスワードを入力してください";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
- (IBAction)login_save:(id)sender {
    if ([_account_adress.text length] == 0  || [_account_pass.text length] == 0  )
        {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"項目に誤りがあります" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self alertbutton];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [self accountLogin];
    }
}

//キーボードをずらすメソッド
-(void) keyboardWillShow:(NSNotification *) notification{
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -70);
        self.view.transform = transform;
    } completion:NULL];
}

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
//キーボードを閉じるメソッド
- (IBAction)adres_return:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)pass_return:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)confpass:(id)sender {
        [sender resignFirstResponder];
}

@end
