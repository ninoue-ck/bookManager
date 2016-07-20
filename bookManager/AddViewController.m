//
//  AddViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/03.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
// ピッカー　http://morizyun.github.io/blog/uitextfield-datepicker-delegate-sender/
//
#import "AddViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface AddViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate> {
    NSString *addImage;
    NSString *addTitle;
    NSString *addPrice;
    NSDate *addDate;
}
@property (weak, nonatomic) IBOutlet UIImageView *addImageField;
@property (weak, nonatomic) IBOutlet UITextField *addTitleField;
@property (weak, nonatomic) IBOutlet UITextField *addPriceField;
@property (weak, nonatomic) IBOutlet UITextField *addDateField;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 日付フィールドがクリックされるとピッカーを出す処理
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    self.addDateField.inputView = datePicker;
    self.addDateField.delegate = self;
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
    // Viewの配置
    self.addDateField.inputAccessoryView = keyboardDoneButtonView;
    
    [self.view addSubview:self.addDateField];
    self.addPriceField.placeholder =@"金額";
    self.addTitleField.placeholder =@"書籍名";
    self.addTitleField.clearButtonMode = UITextFieldViewModeAlways;
    self.addPriceField.clearButtonMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//ピッカー押された後
- (void)updateTextField:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.addDateField.text = [dateFormatter stringFromDate:picker.date];
    addDate=picker.date;
    NSLog(@"add_date %@",addDate);
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [self.addDateField resignFirstResponder];
    self.addDateField = nil;
}

- (IBAction)add_close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//リターンでキーボードを閉じる
- (IBAction)return_title:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)return_price:(id)sender {
    [sender resignFirstResponder];
}

//画像添付の処理
- (IBAction)image_send:(id)sender {
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

//画像の反映
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    self.addImageField.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//書籍追加時のAPI通信メソッド
- (void)addBooks {
    addTitle=self.addTitleField.text;
    addPrice=self.addPriceField.text;
    if (addTitle !=nil && addPrice !=nil && addDate!=nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        NSString *url = @"http://app.com/book/regist";
        NSDictionary *params = [[NSDictionary alloc] init];
        params = @{
                   @"image_url":@"hoge",
                   @"name":self.addTitleField.text,
                   @"price":self.addPriceField.text,
                   @"purchase_date":self.addDateField.text };
        [manager POST:url parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
             [self dismissViewControllerAnimated:YES completion:nil];
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Error: %@", error);
         }
         ];
    }
}

//書籍追加のメソッド
- (IBAction)addBooksSave:(id)sender {
    if([_addTitleField.text length] == 0  || [_addPriceField.text length] == 0)  {
        NSLog(@"%@", self.addPriceField.text);
        NSLog(@"%@", self.addTitleField.text);
        NSLog(@"date %@", self.addDateField.text);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"未入力項目あり" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        [self addBooks];
    }
}

//キーボードが出た時画面を上にずらす
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
@end
