//
//  ListTableViewController.m
//  bookManager
//
//  Created by inouenaoto on 2016/07/02.
//  Copyright © 2016年 inouenaoto. All rights reserved.
//フッター　http://blog.7bunnies.com/2011/09/uitableviewtablefooterviewuibutton.html
//
//
//
//






#import "ListTableViewController.h"
#import "ListTableCell.h"
#define ONCE_READ_COUNT 20//20件ずつ読みこむ



@interface ListTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *Listtable;


@property (nonatomic, strong) NSArray *dataSourceBookTitle;
@property (nonatomic, strong) NSArray *dataSourceBookPrice;
@property (nonatomic, strong) NSArray *dataSourceBookDate;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) NSArray *contents;
@property (readwrite) NSInteger page;


@end

@implementation ListTableViewController

int total = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    _Listtable.dataSource = self;
    _Listtable.delegate = self;
    [_Listtable registerNib:[UINib nibWithNibName:@"ListTableCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following  readMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    self.contents = [self createContents];
    total = [_contents count];
    _page = 1;
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.indicator setColor:[UIColor darkGrayColor]];
    [self.indicator setHidesWhenStopped:YES];
    [self.indicator stopAnimating];
    
}

//以下仮データ
- (NSArray *)createContents
{
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        [data addObject:@"パーフェクトPHP"];
        [data addObject:@"cakePHP辞典"];
        [data addObject:@"パーフェクトじゃないPHP"];
        [data addObject:@"cakeじゃないPHP"];
    }
    
    return [data copy];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _page*ONCE_READ_COUNT;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"ListCell" ;
    ListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.bodyLabel.text = [_contents objectAtIndex:indexPath.row];
    return cell;
}





//テーブルのセルから移動
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[NSString stringWithFormat:@"%d", indexPath.row] forKey:@"num"];
    
    [self performSegueWithIdentifier:@"List_to_Edit" sender:self];
}

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"List_to_Add" sender:self];
    
}


/*　スクロールかボタンか迷い中なのでコメント化
//テーブルの「さらに読みこむ処理の追加
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //一番下までスクロールしたかどうか
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
    {

        //まだ表示するコンテンツが存在するか判定し存在するなら○件分を取得して表示更新する処理をここに書く
    }
}
*/


//もっと読みこむフッター
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton *list_loadbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    list_loadbutton.frame =CGRectMake(0, 0, 320, 60);
    [list_loadbutton setTitle:@"***もっと読み込む***" forState:UIControlStateNormal];
    return list_loadbutton;
}



//インディケータの設定
- (void)reloadMoreData
{
    _page++;
    [self.tableView reloadData];
    [self endIndicator];
}

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


#pragma mark - 表示セルの一番下まできたら次のONCE_READ_COUNT件数取得
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
    {
        
        if([_indicator isAnimating]) {
            return;
        }
        
        
        if (total > (_page*ONCE_READ_COUNT)) {
            [self startIndicator];
            [self performSelector:@selector(reloadMoreData) withObject:nil afterDelay:0.1f];
        }
        
    }
}






/*- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
            return @"      　　　　 ***もっと読みこむ***";//コードで正しく中央署せする
}
 
*/
 
 
 



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




@end
