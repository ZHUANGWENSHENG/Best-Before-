//
//  homepage.m
//  Best Before
//
//  Created by DMT on 2017/12/12.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "homepage.h"
#import "item.h"
#import "addpageTableViewController.h"
#import "addPageViewController.h"
#import "UILabel+TextAlign.h"
#import "ListTableViewController.h"
#import "searchBar.h"
#import "searchView.h"
#import "AFNetworking.h"
#import "BarcodeViewController.h"


@interface homepage ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIView *setting;
    UIView *information;
    NSString *row;
    NSMutableArray *name;
    NSMutableArray *time;
    NSMutableArray *name2;
    NSMutableArray *time2;
    NSMutableArray *idnum;
    UIButton *down;
    NSString *fenlei;
    NSMutableArray *fenlei2;
     NSMutableArray *fenlei1;
    NSMutableArray *beizhu1;
     NSMutableArray *beizhu2;
    
    
    NSMutableArray *scrq;
    NSMutableArray *bzq;
    
    

    
}
@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)NSArray * letter;
@end

@implementation homepage

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    fenlei2=[[NSMutableArray alloc]init];
    beizhu1=[[NSMutableArray alloc]init];
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
   // [self AFNetMonitor];
    //[self AFGetData];
    fenlei=[[NSString alloc]init];
    fenlei=@"全部";
        self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
   
      [self.tableView registerNib:[UINib nibWithNibName:@"item" bundle:nil] forCellReuseIdentifier:@"itemcell"];
   // name=[[NSMutableArray alloc]initWithObjects:@"牛奶",@"香蕉", nil];
    //time=[[NSMutableArray alloc]initWithObjects:@"8",@"9", nil];
   // name2=[[NSMutableArray alloc]initWithObjects:@"牛奶",@"香蕉", nil];
    //time2=[[NSMutableArray alloc]initWithObjects:@"8",@"9", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"全部";
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //去掉多余的线
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    //button
    down = [[UIButton alloc]init];
    UIImage *downimg = [UIImage imageNamed:@"Down Arrow"];
    [down setImage:downimg forState:UIControlStateNormal];
    down.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-12.5 , 54, 25, 4);
    [down addTarget:self action:@selector(alt) forControlEvents:UIControlEventTouchDown];
    [self.navigationController.view addSubview:down];
    
    UIButton *settingopen = [[UIButton alloc]init];
    UIImage *settingimg = [UIImage imageNamed:@"Setting-1"];
    [settingopen setImage:settingimg forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:settingopen];
    self.navigationItem.leftBarButtonItem = left;
    [settingopen addTarget:self action:@selector(settingopenClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *Searchback = [[UIButton alloc]init];
    [Searchback addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchDown];
    UIImage *Searchimg = [UIImage imageNamed:@"Search"];
    [Searchback setImage:Searchimg forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:Searchback];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *add = [[UIButton alloc]init];
    add.layer.masksToBounds = YES;
    add.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*318/375,[UIScreen mainScreen].bounds.size.height*608/667,45,45);
    add.layer.cornerRadius = add.bounds.size.height/2;
    UIImage *addimg = [UIImage imageNamed:@"Add"];
    [add setImage:addimg forState:UIControlStateNormal];
    [self.navigationController.view addSubview:add];
    //写动作
    [add addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *list = [[UIButton alloc]init];
    list.layer.masksToBounds = YES;
    list.frame = CGRectMake([UIScreen mainScreen].bounds.size.width* 165/375,[UIScreen mainScreen].bounds.size.height*608/667,45,45);
    // list.layer.cornerRadius = list.bounds.size.height/2;
    UIImage *listimg = [UIImage imageNamed:@"List"];
    [list setImage:listimg forState:UIControlStateNormal];
    [self.navigationController.view addSubview:list];
    [list addTarget:self action:@selector(listClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *camera = [[UIButton alloc]init];
    camera.layer.masksToBounds = YES;
    camera.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*12/375,[UIScreen mainScreen].bounds.size.height*608/667,45,45);
    //输出值
    float i=[UIScreen mainScreen].bounds.size.width*(12/375);
    NSLog(@"%f",i);
    camera.layer.cornerRadius = camera.bounds.size.height/2;
    UIImage *cameraimg = [UIImage imageNamed:@"Camera"];
    [camera setImage:cameraimg forState:UIControlStateNormal];
    [self.navigationController.view addSubview:camera];
    [camera addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchDown];


    //UIView setting
    
    setting = [[UIView alloc]initWithFrame:CGRectMake(0, 405, [UIScreen mainScreen].bounds.size.width, 282)];
    setting.backgroundColor =[UIColor colorWithRed:0.2353 green:0.3529 blue:0.5883 alpha:1];
    setting.hidden = YES;
    //setting.tag = 100;
    setting.layer.cornerRadius = 20;
    [self.navigationController.view addSubview:setting];
    
    //view下滑手势
    UISwipeGestureRecognizer  *settingrecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom1:)];
    [settingrecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [setting addGestureRecognizer:settingrecognizer];
    
    UIButton *settingdown = [[UIButton alloc]initWithFrame:CGRectMake(318, 200, 45, 45)];
    settingdown.layer.masksToBounds = YES;
    settingdown.layer.cornerRadius = camera.bounds.size.height/2;
    UIImage *settingdownimg = [UIImage imageNamed:@"back-1"];
    [settingdown setImage:settingdownimg forState:UIControlStateNormal];
    [setting addSubview:settingdown];
    [settingdown addTarget:self action:@selector(settingcloseClick) forControlEvents:UIControlEventTouchDown];

    UIImage *set = [UIImage imageNamed:@"settingwhite"];
    UIImageView *setimg = [[UIImageView alloc]init];
    setimg.image = set;
    setimg.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, 20, 40, 40);
    [setting addSubview:setimg];
    
    UILabel *dateformat = [[UILabel alloc]initWithFrame:CGRectMake(8, 90, 200, 30)];
    dateformat.text = @"使用本地日期格式";
    dateformat.textColor = [UIColor whiteColor];
    dateformat.font = [UIFont boldSystemFontOfSize:20];
    //设置label中的文字是否可变，默认值是YES
    dateformat.userInteractionEnabled = NO;
    dateformat.backgroundColor = [UIColor clearColor];
    [setting addSubview:dateformat];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(8, 145, 200, 30)];
    version.text = @"版本";
    version.textColor = [UIColor whiteColor];
    version.font = [UIFont boldSystemFontOfSize:20];
    //设置label中的文字是否可变，默认值是YES
    version.userInteractionEnabled = NO;
    version.backgroundColor = [UIColor clearColor];
    [setting addSubview:version];
    
    UILabel *versionnum = [[UILabel alloc]initWithFrame:CGRectMake(335, 145, 200, 30)];
    versionnum.text = @"1.0";
    versionnum.textColor = [UIColor whiteColor];
    versionnum.font = [UIFont boldSystemFontOfSize:20];
    //设置label中的文字是否可变，默认值是YES
    versionnum.userInteractionEnabled = NO;
    versionnum.backgroundColor = [UIColor clearColor];
    [setting addSubview:versionnum];
    
    UISwitch *switchview = [[UISwitch alloc]initWithFrame:CGRectMake(312, 90, 51, 33)];
    switchview.on = YES;//设置初始为ON的一边
    [setting addSubview:switchview];
    [switchview addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知

    
    //uiview information
   
    //view下滑手势



    

    //[rewrite addTarget:self action:@selector(rewriteClick) forControlEvents:UIControlEventTouchDown];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)cameraClick{
    
    BarcodeViewController *Barcodepage = [[BarcodeViewController alloc]init];
    UINavigationController *Barcodenavi =[[UINavigationController alloc]initWithRootViewController:Barcodepage];
    
    [self presentViewController:Barcodenavi animated:YES completion:nil];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;//第一个展示字母、第二个展示数字
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _letter.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _letter[row];
}
-(void)alt{
    UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alt animated:YES completion:nil];
    UIAlertAction *guan=[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 270, 200)];
    [alt.view addSubview:self.pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.letter = @[@"零食",@"水果",@"饮料",@"全部"];
    UIAlertAction *wan=[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSInteger row=[self.pickerView selectedRowInComponent:0];
        //然后是获取这个行中的值，就是数组中的值
        NSString *value=[_letter objectAtIndex:row];
        fenlei=value;
        self.title=fenlei;
        if([fenlei isEqual:@"全部"]){
            [self AFNetMonitor];
            [self AFGetData];
            [self AFGetData2];
     
        }else if([fenlei isEqual:@"饮料"]){
            [self AFNetMonitor];
            [self AFGetData3];
            [self AFGetData4];
        }
        else if([fenlei isEqual:@"水果"]){
            name=[[NSMutableArray alloc]initWithObjects:@"香蕉", nil];
            time=[[NSMutableArray alloc]initWithObjects:@"2", nil];
            name2=[[NSMutableArray alloc]initWithObjects:@"苹果", nil];
            time2=[[NSMutableArray alloc]initWithObjects:@"1", nil];
        }
        else {
            name=[[NSMutableArray alloc]initWithObjects:@"薯片", nil];
            time=[[NSMutableArray alloc]initWithObjects:@"7", nil];
            name2=[[NSMutableArray alloc]initWithObjects:nil];
            time2=[[NSMutableArray alloc]initWithObjects:nil];
     
        }
    
        [self.tableView reloadData];
        
    }];
    
    
    [alt addAction:guan];
    [alt addAction:wan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)sousuo{
//   
//    search *heihei=[[search alloc]init];
//    [self presentViewController:heihei animated:YES completion:nil];
//    //[self.navigationController pushViewController:heihei animated:YES];
//    
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //warning Incomplete implementation, return the number of rows
    if(section==0){
      //  NSLog(@"aaa%d",name.count);
      
        return name.count;
    }
    else{
       //  NSLog(@"aaa%d",name.count);
        return name2.count;
    }
}
-(void)sousuo{
    searchView *ind=[[searchView alloc]init];
    UINavigationController *search=[[UINavigationController alloc]initWithRootViewController:ind];
   // searchBar *search=[[searchBar alloc]initWithRootViewController:ind];
    [self presentViewController:search animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
};
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
};
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
};


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section ==0){
        UIView *guoqi =[[UIView alloc]init];
        guoqi.backgroundColor =[UIColor whiteColor];
        UILabel *tittlelabel1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-16 , 12.5, 50, 20)];
        tittlelabel1.font = [UIFont systemFontOfSize:16];
        tittlelabel1.text = @"过期";
        tittlelabel1.textColor = [UIColor colorWithRed:238/255.0 green:28/255.0 blue:37/255.0 alpha:1];
        [guoqi addSubview:tittlelabel1];
        
        return guoqi;
    }
    else{
        UIView *xinxian =[[UIView alloc]init];
        xinxian.backgroundColor =[UIColor whiteColor];
        UILabel *tittlelabel2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-16 , 12.5, 50, 20)];
        tittlelabel2.font = [UIFont systemFontOfSize:16];
        tittlelabel2.text = @"新鲜";
        tittlelabel2.textColor = [UIColor colorWithRed:79/255.0 green:210/255.0 blue:98/255.0 alpha:1];
        [xinxian  addSubview:tittlelabel2];
        
        return xinxian;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    item *cell = [tableView dequeueReusableCellWithIdentifier:@"itemcell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        cell.item1.backgroundColor=[UIColor colorWithRed:0.8549 green:0.263 blue:0.212 alpha:1];
        cell.name.text=name[indexPath.row];
        cell.time.text=time[indexPath.row];
        cell.shengyu.text=@"过期";
    }
    else{
        cell.item1.backgroundColor=[UIColor colorWithRed:0.231 green:0.71 blue:0.48 alpha:1];
        cell.name.text=name2[indexPath.row];
        cell.time.text=time2[indexPath.row];
        cell.shengyu.text=@"剩余";
    }
    return cell;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    information = [[UIView alloc]initWithFrame:CGRectMake(0, 236, [UIScreen mainScreen].bounds.size.width, 451)];
    information.backgroundColor = [UIColor colorWithRed:0.2353 green:0.3529 blue:0.5883 alpha:1];
    information.hidden = YES;
    information.layer.cornerRadius = 20;
    [self.navigationController.view addSubview:information];
    
    UISwipeGestureRecognizer  *informationrecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom2:)];
    [informationrecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [information addGestureRecognizer:informationrecognizer];
    
    
    UIButton *informationdown = [[UIButton alloc]initWithFrame:CGRectMake(12, 608-236, 45, 45)];
    informationdown.layer.masksToBounds = YES;
    //informationdown.layer.cornerRadius = infor.bounds.size.height/2;
    UIImage *informationdownimg = [UIImage imageNamed:@"back-1"];
    [informationdown setImage:informationdownimg forState:UIControlStateNormal];
    [information addSubview:informationdown];
    [informationdown addTarget:self action:@selector(informationcloseClick) forControlEvents:UIControlEventTouchDown];
    
    UIButton *rewrite = [[UIButton alloc]initWithFrame:CGRectMake(318, 608-236, 45, 45)];
    rewrite.layer.masksToBounds = YES;
    //rewrite.layer.cornerRadius = camera.bounds.size.height/2;
    UIImage *rewriteimg = [UIImage imageNamed:@"Writing"];
    [rewrite setImage:rewriteimg forState:UIControlStateNormal];
    [information addSubview:rewrite];
    
    UIImage *shape = [UIImage imageNamed:@"Shape"];
    UIImageView *shapeimg = [[UIImageView alloc]init];
    shapeimg.image = shape;
    shapeimg.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-18, 4, 36, 2);
    [information addSubview:shapeimg];
    
    UILabel *name1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 20, 50, 25)];
    name1.text = @"名称";
    name1.textColor = [UIColor colorWithRed:0.6980 green:0.6980 blue:0.6980 alpha:1];
    name1.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    name1.userInteractionEnabled = NO;
    name1.backgroundColor = [UIColor clearColor];
    [information addSubview:name1];
    
    UILabel *nameinfor = [[UILabel alloc]initWithFrame:CGRectMake(12, 51, 200, 35)];
    if(indexPath.section==0){
        nameinfor.text = name[indexPath.row];
    }
    else{
    nameinfor.text = name2[indexPath.row];
    }
    nameinfor.textColor = [UIColor whiteColor];
    nameinfor.font = [UIFont boldSystemFontOfSize:24];
    //设置label中的文字是否可变，默认值是YES
    nameinfor.userInteractionEnabled = YES;
    nameinfor.backgroundColor = [UIColor clearColor];
    [information addSubview:nameinfor];
    
    UILabel *fenlei = [[UILabel alloc]initWithFrame:CGRectMake(12, 90, 50, 25)];
    fenlei.text = @"分类:";
    fenlei.textColor = [UIColor colorWithRed:0.6980 green:0.6980 blue:0.6980 alpha:1];
    fenlei.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    fenlei.userInteractionEnabled = NO;
    fenlei.backgroundColor = [UIColor clearColor];
    [information addSubview:fenlei];
    
    UILabel *fenleiinfor = [[UILabel alloc]initWithFrame:CGRectMake(62, 91, 100, 25)];
    if(indexPath.section==0){
         fenleiinfor.text = fenlei1[indexPath.row];
    }
    else{
         fenleiinfor.text = fenlei2[indexPath.row];
    }
   
    fenleiinfor.textColor = [UIColor colorWithRed:0.6980 green:0.6980 blue:0.6980 alpha:1];
    fenleiinfor.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    fenleiinfor.userInteractionEnabled = YES;
    fenleiinfor.backgroundColor = [UIColor clearColor];
    [information addSubview:fenleiinfor];
    
    UILabel *beizhu = [[UILabel alloc]initWithFrame:CGRectMake(12, 121, 50, 25)];
    beizhu.text = @"备注:";
    beizhu.textColor = [UIColor colorWithRed:0.6980 green:0.6980 blue:0.6980 alpha:1];
    beizhu.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    beizhu.userInteractionEnabled = NO;
    beizhu.backgroundColor = [UIColor clearColor];
    [information addSubview:beizhu];
    
    UILabel *beizhuinfor = [[UILabel alloc]initWithFrame:CGRectMake(62, 110, 300, 50)];
    if(indexPath.section==0){
        beizhuinfor.text = beizhu2[indexPath.row];
    }
    else{
         beizhuinfor.text = beizhu1[indexPath.row];
    }
   beizhuinfor.textColor = [UIColor whiteColor];
    beizhuinfor.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    beizhuinfor.userInteractionEnabled = YES;
    beizhuinfor.backgroundColor = [UIColor clearColor];
    beizhuinfor.numberOfLines=0;//自动换行
       // beizhuinfor.isTop = YES;//置顶
    [information addSubview:beizhuinfor];
    
    UILabel *zhuangtai = [[UILabel alloc]initWithFrame:CGRectMake(12, 190, 100, 25)];
    zhuangtai.text = @"最近过期";
    zhuangtai.textColor = [UIColor colorWithRed:0.870 green:0.2667 blue:0.2353 alpha:1];
    zhuangtai.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    zhuangtai.userInteractionEnabled = YES;
    zhuangtai.backgroundColor = [UIColor clearColor];
    [information addSubview:zhuangtai];
    
    UILabel *text1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 216, 355, 25)];
    if(indexPath.section==0){
    
        NSString *s3=[[NSString alloc]init];
     
        s3=time[indexPath.row];
        NSString *st2 = [NSString stringWithFormat:@"距离保质期限2018年1月1日已经过去了%@天",s3];
        text1.text = st2;
       // text1.text = @"距离保质期限2017-11-15已经过去了8天。";
    }
    else{
   // text1.text = @"距离保质期限2017-11-15还剩8天。";
        NSString *s1=[[NSString alloc]init];
        s1=bzq[indexPath.row];
        NSString *s2=[[NSString alloc]init];
        s2=time2[indexPath.row];
        NSString *st1 = [NSString stringWithFormat:@"距离保质期限%@还剩%@天",s1,s2];
        text1.text = st1;
    }
   
    text1.textColor = [UIColor whiteColor];
    text1.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    text1.userInteractionEnabled = YES;
    text1.backgroundColor = [UIColor clearColor];
    [information addSubview:text1];
    
    UILabel *text2 = [[UILabel alloc]initWithFrame:CGRectMake(12, 246, 350, 25)];
    text2.text = @"请尽快对该物品进行处理。";
    text2.textColor = [UIColor whiteColor];
    text2.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    text2.userInteractionEnabled = YES;
    text2.backgroundColor = [UIColor clearColor];
    [information addSubview:text2];
    
    UILabel *text3 = [[UILabel alloc]initWithFrame:CGRectMake(12, 266, 350, 70)];
    text3.text = @" ";
    text3.textColor = [UIColor whiteColor];
    text3.font = [UIFont boldSystemFontOfSize:18];
    //设置label中的文字是否可变，默认值是YES
    text3.userInteractionEnabled = YES;
    text3.numberOfLines=0;//自动换行
    //text3.isTop = YES;//置顶
    text3.backgroundColor = [UIColor clearColor];
    [information addSubview:text3];
   
    information.hidden =  NO;
}

- (void)informationcloseClick{
    information.hidden = YES;
}

-(void)addClick{

    addPageViewController *addpage = [[addPageViewController alloc]init];
    UINavigationController *addnavi =[[UINavigationController alloc]initWithRootViewController:addpage];

    [self presentViewController:addnavi animated:YES completion:nil];
}

-(void)listClick{
    
    ListTableViewController *Listpage = [[ListTableViewController alloc]init];
    UINavigationController *Listnavi =[[UINavigationController alloc]initWithRootViewController:Listpage];
    
    [self presentViewController:Listnavi animated:YES completion:nil];
}

-(void)settingopenClick{
    setting.hidden = NO;
}

-(void)settingcloseClick{
    setting.hidden = YES;
}


-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
}
//下划
- (void)handleSwipeFrom1:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
       // information.hidden=YES;
        [self settingcloseClick];
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

- (void)handleSwipeFrom2:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        // information.hidden=YES;
        [self informationcloseClick];
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
    [session GET:@"http://127.0.0.1:3000/p" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功");
        
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //  NSLog(@"res=%@",jsonObject);
        
        //idnum=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"id"]];
        name=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        time=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"ri"]];
        fenlei1=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"fenlei"]];
        beizhu2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"beizhu"]];
       // NSLog(@"%@",name);
    //    NSLog(@"%d",name.count);
       
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
    
}
-(void)AFGetData2{
    
    AFHTTPSessionManager* session=[AFHTTPSessionManager manager];
    session.responseSerializer=[AFHTTPResponseSerializer serializer];
    [session GET:@"http://127.0.0.1:3000/m" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功");
        
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //  NSLog(@"res=%@",jsonObject);
        
        idnum=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"id"]];
        name2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        time2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"ri"]];
      
        fenlei2=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"fenlei"]];
        beizhu1=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"beizhu"]];
        
        scrq=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"scrq"]];
        bzq=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"bzq"]];
//        NSLog(@"%@",name2);
//        NSLog(@"%d",name2.count);
        
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self AFNetMonitor];
    [self AFGetData];
    [self AFGetData2];
   
}

-(void)AFDeleteData{
    AFHTTPSessionManager* session=[AFHTTPSessionManager manager];
    session.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"id":row};
    [session DELETE:@"http://127.0.0.1:3000/p" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        
        
    }];
    [self.tableView reloadData];
    [self refresh];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    row = [[NSString alloc] init];
    row=idnum[indexPath.row];
    [self AFDeleteData];
}
- (void)refresh{
 
    if([self.title isEqual:@"全部"]){
        [self AFNetMonitor];
        [self AFGetData];
        [self AFGetData2];
    }
    if([self.title isEqual:@"饮料"]){
        [self AFNetMonitor];
        [self AFGetData3];
        [self AFGetData4];
    }
    else{
        [self AFNetMonitor];
        [self AFGetData];
        [self AFGetData2];
    }
 

   // [self.tableView reloadData];
   // [self viewDidLoad];
   // [self.navigationController pushViewController:self animated:NO];
    [self.refreshControl endRefreshing];
    
}




-(void)AFGetData3{
    
    AFHTTPSessionManager* session=[AFHTTPSessionManager manager];
    session.responseSerializer=[AFHTTPResponseSerializer serializer];
    [session GET:@"http://127.0.0.1:3000/l" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功");
        
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //  NSLog(@"res=%@",jsonObject);
        
        idnum=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"id"]];
        name2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        time2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"ri"]];
        //name=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        //time=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"ri"]];
        fenlei2=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"fenlei"]];
        beizhu1=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"beizhu"]];
        //        NSLog(@"%@",name2);
        //        NSLog(@"%d",name2.count);
    
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
    
}
-(void)AFGetData4{
    
    AFHTTPSessionManager* session=[AFHTTPSessionManager manager];
    session.responseSerializer=[AFHTTPResponseSerializer serializer];
    [session GET:@"http://127.0.0.1:3000/b" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"下载成功");
        
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //  NSLog(@"res=%@",jsonObject);
        
       // idnum=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"id"]];
        //name2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        //time2=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"ri"]];
        name=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"name"]];
        time=[NSMutableArray arrayWithArray:[jsonObject valueForKeyPath:@"ri"]];
        fenlei2=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"fenlei"]];
        beizhu1=[NSMutableArray arrayWithArray:[jsonObject valueForKey:@"beizhu"]];
        //        NSLog(@"%@",name2);
        //        NSLog(@"%d",name2.count);
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"下载失败");
    }];
    
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
