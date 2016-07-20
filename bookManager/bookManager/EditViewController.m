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

@property (strong, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UITextField *bookTitleField;
@property (weak, nonatomic) IBOutlet UITextField *bookPriceField;
@property (weak, nonatomic) IBOutlet UITextField *bookDateField;
@end

@implementation EditViewController

@synthesize selectedTitle;
@synthesize selectedPrice;
@synthesize selectedDate;
@synthesize selectedId;

- (void)viewDidLoad {
    [super viewDidLoad];
    //一覧画面から受け取ったデータ
    self.bookTitleField.text = selectedTitle;
    self.bookPriceField.text = [NSString stringWithFormat:@"%@", selectedPrice];
    self.bookDateField.text = selectedDate;
    
    //日付のフィールドがクリックされるとピッカーになる処理
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    self.bookDateField.inputView = datePicker;
    self.bookDateField.delegate = self;
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle  = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    
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
    self.bookDateField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:self.bookDateField];
    self.bookTitleField.clearButtonMode = UITextFieldViewModeAlways;
    self.bookPriceField.clearButtonMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//ピッカーが押された後の処理
#pragma mark DatePickerの編集が完了したら結果をTextFieldに表示
- (void)updateTextField:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.bookDateField.text = [dateFormatter stringFromDate:picker.date];
    editPurchaseDate=picker.date;
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [self.bookDateField resignFirstResponder];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    self.bookImage.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//キーボードを閉じる処理
- (IBAction)edittitle_return:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)editprice_return:(id)sender {
    [sender resignFirstResponder];
}

//書籍編集のメソッド
- (void)editBook {
    editBookTitle=self.bookTitleField.text;
    editPrice=self.bookPriceField.text;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString *url = @"http://app.com/book/update";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{
               @"id" :selectedId,
               @"name":editBookTitle,
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

- (IBAction)editSave:(id)sender {
    [self editBook];
}

//キーボードが出てきた時に画面をずらすメソッド
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

@end
