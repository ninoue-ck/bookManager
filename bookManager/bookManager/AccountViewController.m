
//
//  AccountViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/06/28.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (IBAction)ga:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)account_close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



///リターンでキーボードを閉じる処理
- (IBAction)mail_return:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)passward_return:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)passconfi_return:(UITextField *)sender {
    [sender resignFirstResponder];
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
