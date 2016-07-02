//
//  AccountViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/03.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//

#import "AccountViewController.h"

@interface AccountViewController ()

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


<<<<<<< HEAD:bookManager/bookManager/AccountViewController.m
///リターンでキーボードを閉じる処理
- (IBAction)mail_return:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)passward_return:(UITextField *)sender {
    [sender resignFirstResponder];
}
=======
>>>>>>> develop:bookManager/AccountViewController.m

- (IBAction)passconfi_return:(UITextField *)sender {
    [sender resignFirstResponder];
}

//モーダル閉じる
- (IBAction)account_close:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
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
