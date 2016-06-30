
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



//キーボードを閉じる処理まとめ
- (IBAction)mail_end:(UITextField *)sender {
     [sender resignFirstResponder];
}
- (IBAction)passward_end:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)passward_confirm:(UITextField *)sender {
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
