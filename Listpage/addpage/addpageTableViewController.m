//
//  addpageTableViewController.m
//  Best Before
//
//  Created by DMT on 2017/12/19.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "addpageTableViewController.h"
#import "addTableViewCell.h"
#import "FengleiTableViewCell.h"
#import "ProducedTableViewCell.h"
#import "ShelflifeTableViewCell.h"
#import "RemindTableViewCell.h"

#import "homepage.h"

@interface addpageTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ProducedTableViewCell *pro;
    UIDatePicker *datePicker;
    UITextField*dateTextField;
    NSLocale*datelocale;
    UIDatePicker *date;
    UILabel *lable;
}


@end

@implementation addpageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self buildDate1];
    [self.tableView registerNib:[UINib nibWithNibName:@"addTableViewCell" bundle:nil] forCellReuseIdentifier:@"Namecell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FengleiTableViewCell" bundle:nil] forCellReuseIdentifier:@"Fengleicell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProducedTableViewCell" bundle:nil] forCellReuseIdentifier:@"Producedcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShelflifeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Shelflifecell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RemindTableViewCell" bundle:nil] forCellReuseIdentifier:@"Remindcell"];
    
    self.tableView.rowHeight = 70.f;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //去掉多余的线
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //导航栏标题
    self.title = @"添加";

    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIButton *confirm = [[UIButton alloc]init];
    confirm.layer.masksToBounds = YES;
    confirm.frame = CGRectMake(318, 544, 45, 45);
    confirm.layer.cornerRadius = confirm.bounds.size.height/2;
//    confirm.backgroundColor =[UIColor redColor];
    UIImage *addimg = [UIImage imageNamed:@"confirm"];
    [confirm setImage:addimg forState:UIControlStateNormal];
    [self.view addSubview:confirm];
    
    //写动作
    [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *back = [[UIButton alloc]init];
    back.layer.masksToBounds = YES;
    back.frame = CGRectMake(12, 544, 45, 45);
    back.layer.cornerRadius = back.bounds.size.height/2;
//    back.backgroundColor =[UIColor redColor];
    UIImage *cameraimg = [UIImage imageNamed:@"back"];
    [back setImage:cameraimg forState:UIControlStateNormal];
    [self.view addSubview:back];
    
    //写动作
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    datePicker= [[UIDatePicker alloc]init];
    datelocale= [[NSLocale alloc]initWithLocaleIdentifier:@"zh_zn"];//设置时区
    datePicker.locale=datelocale;
    datePicker.timeZone= [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    datePicker.datePickerMode=UIDatePickerModeDate;

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
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row == 0||indexPath.row == 5){
    addTableViewCell *name = [tableView dequeueReusableCellWithIdentifier:@"Namecell" forIndexPath:indexPath];
        if(indexPath.row == 0){
            name.nametittle.text = @"物品名称";
        }
        else{
            name.nametittle.text = @"备注";
        }
        return name;
    }
    
    else if(indexPath.row == 1){
        FengleiTableViewCell *fenglei = [tableView dequeueReusableCellWithIdentifier:@"Fengleicell" forIndexPath:indexPath];
        
        return fenglei;
        
    }
    else if(indexPath.row == 2){
        ProducedTableViewCell *produced = [tableView dequeueReusableCellWithIdentifier:@"Producedcell" forIndexPath:indexPath];
        //创建手势识别器对象
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        //设置手势识别器对象的具体属性,例如连续敲击2次
        tap.numberOfTapsRequired = 1;
        // 需要2根手指一起敲击
        tap.numberOfTouchesRequired = 1;
        
        //添加手势识别器到对应的view上
        [produced.produced addGestureRecognizer:tap];
        
        //监听手势的触发
        [tap addTarget:self action:@selector(buildDate1)];
        NSDate *pickerDate = [date date];// 获取用户通过UIDatePicker设置的日期和时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)"];
        NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
        
        //打印显示日期时间
        NSLog(@"格式化显示时间：%@",dateString);
        //lable.text = dateString;
        produced.produced.text=dateString;
        

        return produced;
        
    }
    else if(indexPath.row == 4){
        RemindTableViewCell *remind = [tableView dequeueReusableCellWithIdentifier:@"Remindcell" forIndexPath:indexPath];
        
        return remind;
        
    }
    else{
        ShelflifeTableViewCell *shelflife = [tableView dequeueReusableCellWithIdentifier:@"Shelflifecell" forIndexPath:indexPath];
        
        return shelflife;
        
    }

}

-(void)confirmClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buildDate1{
    date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,200, self.view.frame.size.width, 216)];
    date.datePickerMode=UIDatePickerModeDate;
    date.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:date];
  //  [date addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    date.locale=locale;
    NSDate *localDate=[NSDate date];
    NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offset=[[NSDateComponents alloc]init];
    [offset setYear:0];
    [offset setMonth:0];
    [offset setDay:5];
    NSDate *maxDate = [gregorian dateByAddingComponents:offset toDate:localDate options:0];
    date.minimumDate=localDate;
    date.maximumDate=maxDate;
    lable= [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(date.frame)+20, CGRectGetWidth(date.frame), 30)];
  lable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"显示获取的日期时间";
    [self.view addSubview:lable];


    
}
-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* datel = control.date;
    //添加你自己响应代码
    NSLog(@"dateChanged响应事件：%@",date);
    
    //NSDate格式转换为NSString格式
    NSDate *pickerDate = [date date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    //打印显示日期时间
    NSLog(@"格式化显示时间：%@",dateString);
    lable.text = dateString;
    
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
