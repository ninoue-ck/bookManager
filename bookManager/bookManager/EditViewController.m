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
    //一覧画面から受け取ったデータたち
    _book_title_field.text = selected_title;
    _book_price_field.text = [NSString stringWithFormat:@"%@", selected_price];
    _book_date_field.text = selected_date;
    
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
    _book_title_field.clearButtonMode = UITextFieldViewModeAlways;
    _book_price_field.clearButtonMode = UITextFieldViewModeAlways;

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
    editPurchaseDate=picker.date;
    NSLog(@"edit_date %@",editPurchaseDate);
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [_book_date_field resignFirstResponder];
   //  _book_date_field = nil;
}

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
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

//画像の反映
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
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
    editBook_title=_book_title_field.text;
    editPrice=_book_price_field.text;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    
    NSString *url = @"http://app.com/book/update";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{
               @"id" :selected_id,
               @"name":editBook_title,
               @"image_url":@"hoge",
               @"price":editPrice,
               @"purchase_date":editPurchaseDate
               };

    
    NSLog(@"parms %@", params);

    [manager POST:url parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject)
     {[self.navigationController popViewControllerAnimated:YES];

        }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

- (IBAction)edit_save:(id)sender {
     [self edit_book];
  //  [self.navigationController popViewControllerAnimated:YES];
}

-(void) keyboardWillShow:(NSNotification *) notification{
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -70);
        self.view.transform = transform;
    } completion:NULL];
}

//消えた時戻す
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
