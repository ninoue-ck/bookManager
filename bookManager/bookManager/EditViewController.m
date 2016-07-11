//
//  EditViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//
// ピッカー　http://morizyun.github.io/blog/uitextfield-datepicker-delegate-sender/


#import "EditViewController.h"
#import "ListTableViewController.h"
#import "ListTableCell.h"
#import <AFNetworking/AFNetworking.h>


@interface EditViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *book_image;
@property (weak, nonatomic) IBOutlet UITextField *book_title_field;
@property (weak, nonatomic) IBOutlet UITextField *book_price_field;
@property (weak, nonatomic) IBOutlet UITextField *book_date_field;





@end

@implementation EditViewController


@synthesize selected_title;
@synthesize selected_price;
@synthesize selected_date;
@synthesize selected_id;



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",selected_id);
    _book_title_field.delegate=self;
    _book_price_field.delegate=self;
    
    //一覧から受け取ったデータたち
    self.book_title_field.text = selected_title;
    self.book_price_field.text = selected_price;
    self.book_date_field.text = selected_date;
    
    //ぴっかーを出す
    // DatePickerの設定
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // DatePickerを編集したら、updateTextFieldを呼び出す
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // textFieldの入力をdatePickerに設定
    _book_date_field.inputView = datePicker;
    
    // Delegationの設定
    self.book_date_field.delegate = self;
    
    // DoneボタンとそのViewの作成
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle  = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    
    // 完了ボタンとSpacerの配置
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完了"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(pickerDoneClicked)];
    
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:nil
                                                                            action:nil];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:spacer, spacer1, doneButton, nil]];
    
    // Viewの配置
    _book_date_field.inputAccessoryView = keyboardDoneButtonView;
    
    [self.view addSubview:_book_date_field];
  
 
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//ピッカー押された後
#pragma mark DatePickerの編集が完了したら結果をTextFieldに表示
- (void)updateTextField:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    UIDatePicker *picker = (UIDatePicker *)sender;
    _book_date_field.text = [dateFormatter stringFromDate:picker.date];
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [_book_date_field resignFirstResponder];
    _book_date_field = nil;
}

/*
-(void)piccker_appear{
    //ぴっかーを出す
    // DatePickerの設定
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // DatePickerを編集したら、updateTextFieldを呼び出す
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // textFieldの入力をdatePickerに設定
    _book_date_field.inputView = datePicker;
    
    // Delegationの設定
    self.book_date_field.delegate = self;
    
    // DoneボタンとそのViewの作成
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle  = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    
    // 完了ボタンとSpacerの配置
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完了"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(pickerDoneClicked)];
    
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:nil
                                                                            action:nil];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:spacer, spacer1, doneButton, nil]];
    
    // Viewの配置
    _book_date_field.inputAccessoryView = keyboardDoneButtonView;
    
    [self.view addSubview:_book_date_field];
}

*/





//戻るボタン
- (IBAction)edit_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// リターンでキーボードを閉じる

- (IBAction)title_return:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)price_return:(id)sender {
    [sender resignFirstResponder];
}


//画像の処理
- (IBAction)send_editimage:(id)sender {
    
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

//画像の反映
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.book_image.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//キーボードを閉じる処理

- (IBAction)edittitle_return:(id)sender {
        [sender resignFirstResponder];
}

- (IBAction)editprice_return:(id)sender {
        [sender resignFirstResponder];
}



//書籍追加時のメソッ
- (void)edit_book {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * url = @"http://app.com/book/update";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{
               @"id" : selected_id,
               @"name":_book_title_field.text,
               @"image_url":@"hoge",
               @"price":_book_price_field.text,
               @"purchase_date":_book_date_field.text
               };
    
     NSLog(@"parms %@", params);
 //   NSLog(@"%@", params);
    [manager POST:url parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject)
     {
/*         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"成功" message:@"書籍を編集しました" delegate:self cancelButtonTitle:nil otherButtonTitles:@"やり直す", nil];
         [alertView show];
         [self dismissViewControllerAnimated:YES completion:nil];  */
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}


/*
- (IBAction)add_save:(id)sender {
    [self add];
}
*/
- (IBAction)edit_save:(id)sender {
     [self edit_book];
    [self.navigationController popViewControllerAnimated:YES];
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
