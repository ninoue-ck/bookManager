//
//  ListTableViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//
//
//
//
#import <AFNetworking/AFNetworking.h>
#import "ListTableViewController.h"
#import "ListTableCell.h"
#import "Read_More_Cell.h"
#import "EditViewController.h"
#define ONCE_READ_COUNT 5

@interface ListTableViewController ()

// @property (strong, nonatomic) IBOutlet UITableView *Listtable;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (readwrite) NSInteger page;

@property (strong, nonatomic) NSMutableArray *titleList;
@property (strong, nonatomic) NSMutableArray *priceList;
@property (strong, nonatomic) NSMutableArray *dateList;
@property (strong, nonatomic) NSMutableArray *idList;
@property (strong, nonatomic) NSString *setDate; //時間を書式変更したもの

@end

@implementation ListTableViewController

int add_number = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Read_More_Cell" bundle:nil] forCellReuseIdentifier:@"ReadMoreCell"];

    _page = 1;
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.indicator setColor:[UIColor darkGrayColor]];
    [self.indicator setHidesWhenStopped:YES];
    [self.indicator stopAnimating];

}

- (void)viewWillAppear:(BOOL)animated {
    [self GetJson];
    NSLog(@"get json %@",_titleList);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_page*ONCE_READ_COUNT+1 <= self.titleList.count){
    return _page*ONCE_READ_COUNT+1;
    }
    else{
        return self.titleList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"ListCell" ;
    ListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //最終セルの設定 http://qiita.com/yuto_aka_ike/items/6e2785499e5897725e22
    if((indexPath.row == _page*ONCE_READ_COUNT) || (indexPath.row == self.titleList.count) )
    {
        NSString *identifier = @"ReadMoreCell" ;
        Read_More_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        [cell.Read_Button addTarget:self action:@selector(read_more_button:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
  }
    cell.titleLabel.text = [self.titleList objectAtIndex:indexPath.row];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@円", self.priceList [indexPath.row]];
    cell.bookimageView.image=[ UIImage imageNamed:@"book_sample.jpg" ];

    //　時間の書式変更「http://qiita.com/yuto_aka_ike/items/6e2785499e5897725e22」
    NSString *gmt = self.dateList[indexPath.row];
   
    NSDateFormatter *DF = [[NSDateFormatter alloc] init];
    [DF setDateFormat:@"EEE, dd MM yyy HH:mm:ss Z"];
    [DF setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"JP"]];
    NSDate *date = [DF dateFromString:gmt];
    
    //NSStringに
    NSDateFormatter *outFmt = [[NSDateFormatter alloc] init];
    [outFmt setDateFormat:@"yyyy/MM/dd"];
    _setDate = [outFmt stringFromDate:date];
    
    cell.dateLabel.text = _setDate;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    cell.priceLabel.adjustsFontSizeToFitWidth = YES;
    cell.dateLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}


//テーブルのセルから移動
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"List_to_Edit" sender:self];
}

//セグエが編集画面へのものだった時にデータを渡す
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"List_to_Edit"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EditViewController *editViewController = (EditViewController *)segue.destinationViewController;
        editViewController.selectedTitle = [self.titleList objectAtIndex:indexPath.row];
        editViewController.selectedPrice = [self.priceList objectAtIndex:indexPath.row];
        editViewController.selectedDate = _setDate;
        editViewController.selectedId = [self.idList objectAtIndex:indexPath.row];
    }
}

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"List_to_Add" sender:self];
    
}

//もっと読みこむボタンのイベント
- (void)read_more_button:(UIButton *)sender event:(UIEvent *)event {
        if([_indicator isAnimating]) {
            return;
        }
    
        if (self.titleList.count > _page*ONCE_READ_COUNT)  {
            [self startIndicator];
            [self performSelector:@selector(reloadMoreData) withObject:nil afterDelay:0.1f];
        }
}

//次のワンスリードカウントを読みこむメソッド
- (void)reloadMoreData
{
    _page++;
    [self.tableView reloadData];
    [self endIndicator];
}
//インディケータの設定
- (void)startIndicator
{
    [_indicator startAnimating];
    CGRect footerFrame = self.tableView.tableFooterView.frame;
    footerFrame.size.height += 10.0f;
    
    [_indicator setFrame:footerFrame];
    [self.tableView setTableFooterView:_indicator];
}

- (void)endIndicator
{
    [_indicator stopAnimating];
    [_indicator removeFromSuperview];
    [self.tableView setTableFooterView:nil];
    
}

- (void)GetJson {
    NSString *url = @"http://app.com/book/get";
    NSDictionary *params = [[NSDictionary alloc] init];
    params = @{@"page":@"0-100"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [manager POST:url
       parameters:params
          success:^(NSURLSessionDataTask *operation, id responseObject) {
            //通信に成功した場合の処理
              NSArray *API_Array = [responseObject objectForKey:@"result"];
          
              NSMutableArray *IDArray = [NSMutableArray array];
              NSMutableArray *ImageArray = [NSMutableArray array];
              NSMutableArray *TitleArray = [NSMutableArray array];
              NSMutableArray *PriceArray = [NSMutableArray array];
              NSMutableArray *DateArray = [NSMutableArray array];
          
          //取得したAPIをそれぞれの配列に格納
          // NSLog(@"%@",API_Array);
          for(int i = 0; i < API_Array.count; i++) {
              [IDArray addObject:[API_Array[i] objectForKey:@"id"]];
              [ImageArray addObject:[API_Array[i] objectForKey:@"image_url"]];
              [TitleArray addObject:[API_Array[i] objectForKey:@"name"]];
              [PriceArray addObject:[API_Array[i] objectForKey:@"price"]];
              [DateArray addObject:[API_Array[i] objectForKey:@"purchase_date"]];

          }
            self.titleList = TitleArray;
            self.priceList = PriceArray;
            self.dateList = DateArray;
            self.idList = IDArray;
          [self.tableView reloadData];
      } failure:^(NSURLSessionDataTask *operation, NSError *error) {
          NSLog(@"failed: %@", error);
      }];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
