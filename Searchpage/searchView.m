//
//  searchView.m
//  Best Before
//
//  Created by Patatas on 2018/1/6.
//  Copyright © 2018年 Patatas. All rights reserved.
//

#import "searchView.h"
#import "homepage.h"
#import "item.h"
#import "addpageTableViewController.h"
#import "addPageViewController.h"
#import "UILabel+TextAlign.h"
#import "ListTableViewController.h"

@interface searchView ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    UITextField *_input;
    UISearchBar *customSearchBar;
    NSArray *arr;
    NSArray* searchData;
}

@end
bool isSearch;
@implementation searchView

- (void)viewDidLoad {
    [super viewDidLoad];
    isSearch=YES;
    self.tableView.tableFooterView=[[UIView alloc]init];
    arr=[[NSArray alloc]initWithObjects:@"aaa",@"bbb",@"ccc", nil];
    UIButton *quxiao=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, 20, 50, 44)];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchDown];

         self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width-50, 44)];
    [quxiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:quxiao];

    //customSearchBar.showsCancelButton = YES;
    customSearchBar.searchBarStyle = UISearchBarStyleDefault;
   
    
    _input=[customSearchBar valueForKey:@"_searchField"];
    [_input setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    customSearchBar.delegate = self;
    customSearchBar.placeholder=@"牛奶";
    customSearchBar.backgroundColor=[UIColor whiteColor];
    customSearchBar.layer.masksToBounds=YES;
    customSearchBar.layer.cornerRadius=5;
    customSearchBar.searchBarStyle=UISearchBarStyleMinimal;
    [self.navigationController.view addSubview:customSearchBar];
    [self.tableView registerNib:[UINib nibWithNibName:@"item" bundle:nil] forCellReuseIdentifier:@"itemcell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //warning Incomplete implementation, return the number of sections
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
};
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"----searchBarCancelButtonClicked------");
    // 取消搜索状态
    [customSearchBar resignFirstResponder];
    //isSearch = NO;
    //  [self dismissViewControllerAnimated:YES completion:nil];
    // [self.tableView reloadData];
}
#pragma mark - Table view data source
-(void)quxiao{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    item *cell = [tableView dequeueReusableCellWithIdentifier:@"itemcell" forIndexPath:indexPath];
     NSInteger rowNo = indexPath.row;
//    if (indexPath.section==0) {
//        cell.item1.backgroundColor=[UIColor colorWithRed:0.8549 green:0.263 blue:0.212 alpha:1];
//        cell.name.text = [searchData objectAtIndex:rowNo];
//        //cell.name.text=name[indexPath.row];
//        //cell.time.text=time[indexPath.row];
//    }
//    else{
//       cell.name.text = [searchData objectAtIndex:rowNo];
//        cell.item1.backgroundColor=[UIColor colorWithRed:0.231 green:0.71 blue:0.48 alpha:1];
//        //cell.name.text=name2[indexPath.row];
//        //cell.time.text=time2[indexPath.row];
//    }
    if(isSearch)
    {
        // 使用searchData作为表格显示的数据
        cell.name.text = [searchData objectAtIndex:rowNo];
        // cell.titleLable.text=[searchData2 objectAtIndex:rowNo];
    }
    else{
        // 否则使用原始的tableData作为表格显示的数据
        cell.name.text = [arr objectAtIndex:rowNo];
        //  cell.titleLable.text=[arr2 objectAtIndex:rowNo];
    }
//    if(isSearch)
//    {
//        // 使用searchData作为表格显示的数据
//        cell.name.text = [searchData objectAtIndex:rowNo];
//        // cell.titleLable.text=[searchData2 objectAtIndex:rowNo];
//    }
//    else{
//        // 否则使用原始的tableData作为表格显示的数据
//        cell.name.text = [arr objectAtIndex:rowNo];
//        //  cell.titleLable.text=[arr2 objectAtIndex:rowNo];
//    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if(isSearch)
    {
        
        return searchData.count;
        
    }
    else
    {
        
        return arr.count;
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    NSLog(@"----textDidChange------");
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----searchBarSearchButtonClicked------");
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [customSearchBar resignFirstResponder];
}
- (void) filterBySubstring:(NSString*) subStr
{
    NSLog(@"----filterBySubstring------");
    // 设置为搜索状态
    isSearch = YES;
    // 定义搜索谓词
    NSPredicate* pred = [NSPredicate predicateWithFormat:
                         @"SELF CONTAINS[c] %@" , subStr];
    // 使用谓词过滤NSArray
   
    searchData = [arr filteredArrayUsingPredicate:pred];
    
    // 让表格控件重新加载数据
    [self.tableView reloadData];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
