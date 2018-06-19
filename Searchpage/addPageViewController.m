
//
//  addPageViewController.m
//  Best Before
//
//  Created by QUAQUA on 2017/12/29.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "addPageViewController.h"
#import "AFNetworking.h"

@interface addPageViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIDatePicker *datel;
    UILabel *lable;
    NSDate *date;
    NSDate *date2;
    NSString  *string;
     NSString  *string1;
}
@property (weak, nonatomic) IBOutlet UITextField *wupingmingcheng;
@property (weak, nonatomic) IBOutlet UILabel *baizhiqi;


@property (weak, nonatomic) IBOutlet UILabel *fenlei;


@property (weak, nonatomic) IBOutlet UILabel *shengchengri;

@property (weak, nonatomic) IBOutlet UITextField *tian;
@property (weak, nonatomic) IBOutlet UITextField *beizhu;



@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)NSArray * letter;
@end

@implementation addPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_tian.clearButtonMode=UITextFieldViewModeAlways;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"添加";
    _wupingmingcheng.delegate=self;
    

    _tian.delegate=self;
    _beizhu.delegate=self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    //设置手势识别器对象的具体属性,例如连续敲击2次
    tap.numberOfTapsRequired = 1;
    // 需要2根手指一起敲击
    tap.numberOfTouchesRequired = 1;
    _shengchengri.userInteractionEnabled=YES;
    //添加手势识别器到对应的view上
    [_shengchengri addGestureRecognizer:tap];
    
    //监听手势的触发
    [tap addTarget:self action:@selector(buildDate1)];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    
    //设置手势识别器对象的具体属性,例如连续敲击2次
    tap2.numberOfTapsRequired = 1;
    // 需要2根手指一起敲击
    tap2.numberOfTouchesRequired = 1;
    _fenlei.userInteractionEnabled=YES;
    //添加手势识别器到对应的view上
    [_fenlei addGestureRecognizer:tap2];
    [tap2 addTarget:self action:@selector(buildDate2)];
    //_shengchengri.text=lable.text;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] init];
    
    //设置手势识别器对象的具体属性,例如连续敲击2次
    tap3.numberOfTapsRequired = 1;
    // 需要2根手指一起敲击
    tap3.numberOfTouchesRequired = 1;
    _baizhiqi.userInteractionEnabled=YES;
    //添加手势识别器到对应的view上
    [_baizhiqi addGestureRecognizer:tap3];
    
    //监听手势的触发
    [tap3 addTarget:self action:@selector(buildDate3)];
}
-(void)buildDate2{
    UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alt animated:YES completion:nil];
    UIAlertAction *guan=[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
 
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 270, 200)];
    [alt.view addSubview:self.pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.letter = @[@"饮料",@"水果",@"零食",@"全部"];
    UIAlertAction *wan=[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        NSInteger row=[self.pickerView selectedRowInComponent:0];
       //然后是获取这个行中的值，就是数组中的值
        NSString *value=[_letter objectAtIndex:row];
        _fenlei.text=value;
    }];
    
    [alt addAction:guan];
    [alt addAction:wan];
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
- (IBAction)xiala:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)wancheng:(id)sender {
    [self AFNetMonitor];
    [self AFGetData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buildDate1{
  
    
    
   
    
    UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alt animated:YES completion:nil];
    UIAlertAction *guan=[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
    datel=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,270,200)];
    datel.datePickerMode=UIDatePickerModeDate;
    datel.backgroundColor=[UIColor whiteColor];
    //[self.view addSubview:datel];
    //[date addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datel.locale=locale;
   // [datel setTimeZone:[NSTimeZone localTimeZone]];
   // NSDate *localDate=[NSDate date];
   // NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offset=[[NSDateComponents alloc]init];
    [offset setYear:10];
    [offset setMonth:10];
    [offset setDay:100];
   // NSDate *maxDate = [gregorian dateByAddingComponents:offset toDate:localDate options:0];
   // datel.minimumDate=localDate;
   // datel.maximumDate=maxDate;

    alt.view.backgroundColor=[UIColor whiteColor];
    
    
    UIAlertAction *wan=[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        date = datel.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        string = [[NSString alloc]init];
        string = [dateFormatter stringFromDate:date];
        _shengchengri.text=string;
    }];
    
    [alt addAction:guan];
    [alt addAction:wan];
    [alt.view addSubview:datel];
    
}
-(void)buildDate3{
    UIAlertController *alt=[UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alt animated:YES completion:nil];
    UIAlertAction *guan=[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
    datel=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,270,200)];
    datel.datePickerMode=UIDatePickerModeDate;
    datel.backgroundColor=[UIColor whiteColor];
    //[self.view addSubview:datel];
    //[date addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datel.locale=locale;
    // [datel setTimeZone:[NSTimeZone localTimeZone]];
    // NSDate *localDate=[NSDate date];
    // NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offset=[[NSDateComponents alloc]init];
    [offset setYear:10];
    [offset setMonth:10];
    [offset setDay:100];
    // NSDate *maxDate = [gregorian dateByAddingComponents:offset toDate:localDate options:0];
    // datel.minimumDate=localDate;
    // datel.maximumDate=maxDate;
    
    alt.view.backgroundColor=[UIColor whiteColor];
    
    
    UIAlertAction *wan=[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        date2 = datel.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        string1 = [[NSString alloc]init];
        string1 = [dateFormatter stringFromDate:date2];
        _baizhiqi.text=string1;
        NSDateInterval *timeDifference = [[NSDateInterval alloc] initWithStartDate:[date earlierDate:date2] endDate:[date laterDate:date2]];
        int daysFrom = round(timeDifference.duration / 86400);
        _tian.text= [NSString stringWithFormat:@"%d",daysFrom];
    }];
    
    [alt addAction:guan];
    [alt addAction:wan];
    [alt.view addSubview:datel];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_tian resignFirstResponder];
    [_wupingmingcheng resignFirstResponder];
    [_beizhu resignFirstResponder];

 

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
   // NSString *str1=[[NSString alloc]init];
//    str1=_putphone.text;
//    NSString *str2=[[NSString alloc]init];
//    str2=_putpassw.text;
//    NSString *str3 = [[NSString alloc] initWithString:[NSString stringWithFormat:@"小可爱001"]];
    int a=arc4random()%99;
    if([_fenlei.text isEqual:@"饮料"]){
    // NSStrsssing *str1=[[NSString alloc] initWithString:@"arc4random()%9"];
    NSString *str1 = [NSString stringWithFormat:@"%d",a];
        NSLog(@"%@",_tian.text);
//    NSString *str2=[NSString stringWithFormat:];
      // NSString *str2=[NSString stringWithFormat:@"%@",_shengchengri.text];
      //  NSLog(@"%@",str2);
        NSDictionary *parameters = @{@"id":str1,@"name":_wupingmingcheng.text,@"fenlei":_fenlei.text,@"scrq":_shengchengri.text,@"beizhu":_beizhu.text,@"bzq":_baizhiqi.text,@"ri":_tian.text};
    NSLog(@"%@",parameters);
    [session POST:@"http://127.0.0.1:3000/q" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        
    }];
    [session POST:@"http://127.0.0.1:3000" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功");
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
            
    }];

    }
    else{
        
        NSString *str1 = [NSString stringWithFormat:@"%d",a];
        NSLog(@"%@",_tian.text);
        NSDictionary *parameters = @{@"id":str1,@"name":_wupingmingcheng.text,@"fenlei":_fenlei.text,@"scrq":_shengchengri.text,@"beizhu":_beizhu.text,@"bzq":_baizhiqi.text,@"ri":_tian.text};
        NSLog(@"%@",parameters);
        [session POST:@"http://127.0.0.1:3000" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功");
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
            
        }];
    }
    
}
//-(void)dateChanged:(id)sender{
//    //UIDatePicker *control = (UIDatePicker*)sender;
//    //NSDate* date = control.date;
//    //添加你自己响应代码
//    //NSLog(@"dateChanged响应事件：%@",date);
//
//    //NSDate格式转换为NSString格式
//    NSDate *pickerDate = [datel date];// 获取用户通过UIDatePicker设置的日期和时间
//    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
//    [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)"];
//    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
//    NSLog(@"%@",dateString);
//    //打印显示日期时间
//    NSLog(@"格式化显示时间：%@",dateString);
//    _shengchengri.text = dateString;
//
//}


//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [_wupingmingcheng resignFirstResponder];
//    [_tian resignFirstResponder];
//    [_beizhu resignFirstResponder];
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
