//
//  ListTableViewController.m
//  Best Before
//
//  Created by DMT on 2017/12/25.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewCell.h"
#import "homepage.h"
#import "addPageViewController.h"
#import "AFNetworking.h"


@interface ListTableViewController (){
    UIView *listinformation;
    UIView *haha;
    NSMutableArray *mingzi;
    NSMutableArray *num;
    NSMutableArray *thing1;
    NSMutableArray *thing2;
    NSMutableArray *thing3;
}

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Listcell"];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 60.f;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //去掉多余的线
    self.tableView.tableFooterView=[[UIView alloc]init];
    //导航栏标题
    self.title = @"清单";
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIButton *listadd = [[UIButton alloc]init];
    listadd.layer.masksToBounds = YES;
    listadd.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*318/375,[UIScreen mainScreen].bounds.size.height*608/667,45,45);
    listadd.layer.cornerRadius = listadd.bounds.size.height/2;
    UIImage *addimg = [UIImage imageNamed:@"Add"];
    [listadd setImage:addimg forState:UIControlStateNormal];
    [listadd addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchDown];
    [self.navigationController.view addSubview:listadd];
    //写动作
    //[listadd addTarget:self action:@selector(listaddClick) forControlEvents:UIControlEventTouchDown];

    UIButton *listdown = [[UIButton alloc]init];
    listdown.layer.masksToBounds = YES;
    listdown.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*12/375,[UIScreen mainScreen].bounds.size.height*608/667,45,45);
    listdown.layer.cornerRadius = listdown.bounds.size.height/2;
    UIImage * listdownimg = [UIImage imageNamed:@"back"];
    [listdown setImage: listdownimg forState:UIControlStateNormal];
    [self.navigationController.view addSubview:listdown];
    [listdown addTarget:self action:@selector(listcloseClick) forControlEvents:UIControlEventTouchDown];
    
//    listinfor view
//    listinformation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 450)];
//    //listinformation.backgroundColor = [UIColor colorWithRed:0.2353 green:0.3529 blue:0.5883 alpha:1];
//    listinformation.backgroundColor=[UIColor redColor];
////    listinformation.hidden = NO;
////    listinformation.layer.cornerRadius = 20;
//    [self.navigationController.view addSubview:listinformation];
    
   
    
    UIButton *listinfordown = [[UIButton alloc]initWithFrame:CGRectMake(12, 347, 45, 45)];
    listinfordown.layer.masksToBounds = YES;
    //listinfordown.layer.cornerRadius = camera.bounds.size.height/2;
    UIImage *listinfordownimg = [UIImage imageNamed:@"back-1"];
    [listinfordown setImage:listinfordownimg forState:UIControlStateNormal];
    [listinfordown addSubview:listinformation];
    //[listinfordown addTarget:self action:@selector(listinforcloseClick) forControlEvents:UIControlEventTouchDown];
    
    
    // Uncomment the following line to preserve selection between presentations.
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//-(void)add{
//    addPageViewController *addpage=[[addPageViewController alloc]init];
//    [self.navigationController pushViewController:addpage animated:YES];
//}
- (void)handleSwipeFrom2:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        // information.hidden=YES;
        haha.hidden=YES;
        NSLog(@"swipe down");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    return mingzi.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Listcell" forIndexPath:indexPath];
    
    cell.name.text=mingzi[indexPath.row];
    cell.shuliang.text=num[indexPath.row];
    return cell;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    haha=[[UIView alloc]initWithFrame:CGRectMake(0, (667-450), [UIScreen mainScreen].bounds.size.width, 470)];
    haha.backgroundColor=[UIColor colorWithRed:0.2353 green:0.3529 blue:0.5883 alpha:1];
    haha.layer.cornerRadius=20;
    [self.navigationController.view addSubview:haha];
    haha.hidden=NO;
    UILabel *qindan=[[UILabel alloc]initWithFrame:CGRectMake(12, (265-238), 71, 25)];
    qindan.text=@"清单名称";
    qindan.font=[UIFont  boldSystemFontOfSize:17];
    qindan.textColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    [haha addSubview:qindan];
    UILabel *place=[[UILabel alloc]initWithFrame:CGRectMake(12, (290-238), 48, 33)];
    place.text=mingzi[indexPath.row];
    place.font=[UIFont  boldSystemFontOfSize:23];
    place.textColor=[UIColor whiteColor];
    [haha addSubview:place];
    
    UILabel *t1=[[UILabel alloc]initWithFrame:CGRectMake(50, (330-238), 250, 25)];
    t1.text=thing1[indexPath.row];
    t1.font=[UIFont  boldSystemFontOfSize:18];
    t1.textColor=[UIColor whiteColor];
    [haha addSubview:t1];

    UILabel *t2=[[UILabel alloc]initWithFrame:CGRectMake(50, (360-238), 250, 25)];
    t2.text=thing2[indexPath.row];
    t2.font=[UIFont  boldSystemFontOfSize:18];
    t2.textColor=[UIColor whiteColor];
    [haha addSubview:t2];

    UILabel *t3=[[UILabel alloc]initWithFrame:CGRectMake(50, (390-238), 250, 25)];
    t3.text=thing3[indexPath.row];
    t3.font=[UIFont  boldSystemFontOfSize:18];
    t3.textColor=[UIColor whiteColor];
    [haha addSubview:t3];

    
    
    
    UIImage *hen = [UIImage imageNamed:@"Shape"];
    UIImageView *henhen = [[UIImageView alloc]init];
    henhen.image = hen;
    henhen.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-18, (244-238),36, 2);
    [haha addSubview:henhen];
    
    UIImage *cha = [UIImage imageNamed:@"Icon"];
    UIImageView *quxiao = [[UIImageView alloc]init];
    quxiao.image = cha;
    quxiao.frame = CGRectMake(335, (259-238),24, 24);
    [haha addSubview:quxiao];
  
    UISwipeGestureRecognizer  *informationrecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom2:)];
    [informationrecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [haha addGestureRecognizer:informationrecognizer];

}
-(void)AFNetMonitor{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
         switch(status){
             case AFNetworkReachabilityStatusNotReachable:
                 NSLog(@"无网络连接！");
                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 NSLog(@"通过wifi连接的网络");
             case AFNetworkReachabilityStatusReachableViaWWAN:
             {
                 NSLog(@"通过4g");
             }
             default:
                 break;
         }
     }];
}
-(void)AFGetData{
    
    AFHTTPSessionManager* session=[AFHTTPSessionManager manager];
    session.responseSerializer=[AFHTTPResponseSerializer serializer];
    [session GET:@"http://127.0.0.1:3000/c" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功");
        
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //  NSLog(@"res=%@",jsonObject);
        mingzi=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        num=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"number"]];
        thing1=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"t1"]];
        thing2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"t2"]];
        thing3=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"t3"]];
        
     
        
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self AFNetMonitor];
    [self AFGetData];
}
- (void)listcloseClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}




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
