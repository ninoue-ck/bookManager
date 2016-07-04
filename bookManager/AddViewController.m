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

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *add_image;
@property (weak, nonatomic) IBOutlet UITextField *add_title;
@property (weak, nonatomic) IBOutlet UITextField *add_price;
@property (weak, nonatomic) IBOutlet UITextField *add_date;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ぴっかーを出す
    // DatePickerの設定
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // DatePickerを編集したら、updateTextFieldを呼び出す
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // textFieldの入力をdatePickerに設定
    _add_date.inputView = datePicker;
    
    // Delegationの設定
    self.add_date.delegate = self;
    
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
    _add_date.inputAccessoryView = keyboardDoneButtonView;
    
    [self.view addSubview:_add_date];
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
    _add_date.text = [dateFormatter stringFromDate:picker.date];
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [_add_date resignFirstResponder];
    _add_date = nil;
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
    self.add_image.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}






@end
