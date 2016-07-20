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
#import"AppDelegate.h"

@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountAdress;
@property (weak, nonatomic) IBOutlet UITextField *accountPass;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountAdress.placeholder =@"メースアドレスを入力してください";
    self.accountPass.placeholder =@"パスワードを入力してください";
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
    params = @{@"mail_address" : self.accountAdress.text,
               @"password" : self.accountPass.text,
               };

    [manager POST:url
       parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [self toListTableView];
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              [self showAlertController];
          }];
}

- (void)toListTableView {
    //タブをルートにして遷移するメソッド
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

//モーダル閉じる
- (IBAction)loginSave:(id)sender {
    if ([self.accountAdress.text length] == 0  || [self.accountPass.text length] == 0  ) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"項目に誤りがあります" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        [self accountLogin];
    }
}

//キーボードをずらすメソッド
- (void)showKeyboard:(NSNotification *) notification {
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^ {
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -70);
        self.view.transform = transform;
    } completion:NULL];
}

- (void)hideKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
//キーボードを閉じるメソッド
- (IBAction)returnMail:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)returnPass:(id)sender {
    [sender resignFirstResponder];
}


- (void)showAlertController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"項目に誤りがあります" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
