<<<<<<< HEAD:bookManager/bookManager/AddViewController.m

// http://morizyun.github.io/blog/uitextfield-datepicker-delegate-sender/
// http://snippets.feb19.jp/?p=303
//
=======
>>>>>>> develop:bookManager/AddViewController.m
//
//  AddViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/03.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
=======
// ピッカー　http://morizyun.github.io/blog/uitextfield-datepicker-delegate-sender/
//

>>>>>>> develop:bookManager/AddViewController.m

#import "AddViewController.h"

@interface AddViewController ()
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
@property (weak, nonatomic) IBOutlet UITextField *book_title;
@property (weak, nonatomic) IBOutlet UITextField *book_price;
@property (weak, nonatomic) IBOutlet UITextField *book_date;
@property (weak, nonatomic) IBOutlet UIImageView *book_image;
=======

@property (weak, nonatomic) IBOutlet UIImageView *add_image;
@property (weak, nonatomic) IBOutlet UITextField *add_title;
@property (weak, nonatomic) IBOutlet UITextField *add_price;
@property (weak, nonatomic) IBOutlet UITextField *add_date;
>>>>>>> develop:bookManager/AddViewController.m

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
     // DatePickerの設定
    UIDatePicker* datePicker = [[UIDatePicker alloc]init];
=======
    //ぴっかーを出す
    // DatePickerの設定
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
>>>>>>> develop:bookManager/AddViewController.m
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // DatePickerを編集したら、updateTextFieldを呼び出す
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // textFieldの入力をdatePickerに設定
    _add_date.inputView = datePicker;
    
    // Delegationの設定
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
    self.book_date.delegate = self;
=======
    self.add_date.delegate = self;
>>>>>>> develop:bookManager/AddViewController.m
    
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
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
    
    _book_date.inputAccessoryView = keyboardDoneButtonView;

    [self.view addSubview:_book_date];
    
    // Do any additional setup after loading the view.
}


=======
    _add_date.inputAccessoryView = keyboardDoneButtonView;
    
    [self.view addSubview:_add_date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//ピッカー押された後
>>>>>>> develop:bookManager/AddViewController.m
#pragma mark DatePickerの編集が完了したら結果をTextFieldに表示
- (void)updateTextField:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    UIDatePicker *picker = (UIDatePicker *)sender;
    _add_date.text = [dateFormatter stringFromDate:picker.date];
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
    [_book_date resignFirstResponder];
    _book_date = nil;
}


=======
    [_add_date resignFirstResponder];
    _add_date = nil;
}




>>>>>>> develop:bookManager/AddViewController.m

- (IBAction)add_close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
=======
//リターンでキーボードを閉じる
- (IBAction)return_title:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)return_price:(id)sender {
    [sender resignFirstResponder];
>>>>>>> develop:bookManager/AddViewController.m
}


//閉じるボタン
- (IBAction)add_close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
<<<<<<< HEAD:bookManager/bookManager/AddViewController.m
    self.book_image.image = image;

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}







//returnでキーボードを閉じる
- (IBAction)booktitle_return:(UITextField *)sender {
    [sender resignFirstResponder];
=======
    self.add_image.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
>>>>>>> develop:bookManager/AddViewController.m
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
