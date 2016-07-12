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
<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    
    NSString *add_image;
    NSString *add_title;
    NSString *add_price;
    NSDate *add_date;
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *add_image_field;
@property (weak, nonatomic) IBOutlet UITextField *add_title_field;
@property (weak, nonatomic) IBOutlet UITextField *add_price_field;
@property (weak, nonatomic) IBOutlet UITextField *add_date_field;


@end

@implementation AddViewController

//@synthesize add_title_field;
//@synthesize add_price_field;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //ぴっかーを出す
//    add_title_field.delegate=self;
//    add_price_field.delegate=self;
    
 
    //ぴっかーを出す
    // DatePickerの設定
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // DatePickerを編集したら、updateTextFieldを呼び出す
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // textFieldの入力をdatePickerに設定
    _add_date_field.inputView = datePicker;
    
    // Delegationの設定
    self.add_date_field.delegate = self;
    
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
    _add_date_field.inputAccessoryView = keyboardDoneButtonView;
    
    [self.view addSubview:_add_date_field];
    [self text_default];
}


-(void)text_default{
    
    
    _add_price_field.placeholder =@"金額";
    _add_title_field.placeholder =@"書籍名";
    _add_title_field.clearButtonMode = UITextFieldViewModeAlways;
   _add_price_field.clearButtonMode = UITextFieldViewModeAlways;

    
    
    
    
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
    _add_date_field.text = [dateFormatter stringFromDate:picker.date];
    add_date=[dateFormatter stringFromDate:picker.date];
    
}

#pragma mark datepickerの完了ボタンが押された場合
- (void)pickerDoneClicked {
    [_add_date_field resignFirstResponder];
    _add_date_field = nil;
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
    self.add_image_field.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//書籍追加時のメソッ
- (void)add {
    
//    if([_add_title_field.text length] == 0  || [_add_price_field.text length] == 0 || [_add_date_field.text length] == 0)  {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString *url = @"http://app.com/book/regist";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{
               @"image_url":@"hoge",
               @"name":_add_title_field.text,
               @"price":_add_price_field.text,
               @"purchase_date":_add_date_field.text
               };
    NSLog(@"parms %@",params);
    NSLog(@"%@",_add_price_field.text);
    [manager POST:url parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [self dismissViewControllerAnimated:YES completion:nil];

    /*     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"成功" message:@"書籍を追加しました" delegate:self cancelButtonTitle:nil otherButtonTitles:@"やり直す", nil];
         [alertView show];  */
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
/*    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"み入力項目あり" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self alertButtonTap];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }  */
}

- (IBAction)add_save:(id)sender {
    if([_add_title_field.text length] == 0  || [_add_price_field.text length] == 0)  {
        NSLog(@"%@", _add_price_field.text);
        NSLog(@"%@", _add_title_field.text);
        NSLog(@"date %@", _add_date_field.text);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"み入力項目あり" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self alertButton];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
}else{
    [self add];
    }
}
- (void)alertButton {
    
}


@end
