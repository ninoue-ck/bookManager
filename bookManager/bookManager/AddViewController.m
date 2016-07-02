
// http://morizyun.github.io/blog/uitextfield-datepicker-delegate-sender/
// http://snippets.feb19.jp/?p=303
//
//
//  AddViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/06/28.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *book_title;
@property (weak, nonatomic) IBOutlet UITextField *book_price;
@property (weak, nonatomic) IBOutlet UITextField *book_date;
@property (weak, nonatomic) IBOutlet UIImageView *book_image;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // DatePickerの設定
    UIDatePicker* datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // DatePickerを編集したら、updateTextFieldを呼び出す
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // textFieldの入力をdatePickerに設定
    _book_date.inputView = datePicker;
    
    // Delegationの設定
    self.book_date.delegate = self;
    
    // DoneボタンとそのViewの作成
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
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
    
    _book_date.inputAccessoryView = keyboardDoneButtonView;

    [self.view addSubview:_book_date];
    
    // Do any additional setup after loading the view.
}


#pragma mark DatePickerの編集が完了したら結果をTextFieldに表示
- (void)updateTextField:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    UIDatePicker *picker = (UIDatePicker *)sender;
    _book_date.text = [dateFormatter stringFromDate:picker.date];
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [_book_date resignFirstResponder];
    _book_date = nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//閉じるボタン
- (IBAction)add_close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//画像貼付ボタンが押された時にアルバムを開く
- (IBAction)imagebutton_Tapped:(id)sender {
    
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







//returnでキーボードを閉じる
- (IBAction)booktitle_return:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)bookprice_return:(UITextField *)sender {
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
