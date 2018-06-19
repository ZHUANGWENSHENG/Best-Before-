//
//  BarcodeViewController.m
//  Best Before
//
//  Created by DMT on 2018/1/8.
//  Copyright © 2018年 Patatas. All rights reserved.
//

#import "BarcodeViewController.h"
#import "homepage.h"
#import <AVFoundation/AVFoundation.h>
#define SCANVIEW_EdgeTop 150.0
#define SCANVIEW_EdgeLeft 60.0
#define TINTCOLOR_ALPHA 0.2 //浅色透明度
#define DARKCOLOR_ALPHA 0.5 //深色透明度
#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BarcodeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    AVCaptureSession * session;//输入输出的中间桥梁
    UIView *AVCapView;//此 view 用来放置扫描框、取消按钮、说明 label
    UIView *_QrCodeline;//上下移动绿色的线条
    NSTimer *_timer;
}

@end

@implementation BarcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touch];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"扫描";
    
    UIButton *back = [[UIButton alloc]init];
    back.layer.masksToBounds = YES;
    back.frame = CGRectMake(12, 608, 45, 45);
    back.layer.cornerRadius = back.bounds.size.height/2;
    //    back.backgroundColor =[UIColor redColor];
    UIImage *backimg = [UIImage imageNamed:@"back"];
    [back setImage:backimg forState:UIControlStateNormal];
    [self.navigationController.view addSubview:back];
    [back addTarget:self action:@selector(backhomeClick) forControlEvents:UIControlEventTouchDown];
    
    UIView *AVCapView;//此 view 用来放置扫描框、说明 label
    
    //创建一个 view 来放置扫描区域、说明 label、取消按钮
    //背景色
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height )];
    AVCapView = tempView;
    AVCapView.backgroundColor = [UIColor colorWithRed:54.f/255 green:53.f/255 blue:58.f/255 alpha:1];
    
//    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, [UIScreen mainScreen].bounds.size.height - 100, 50, 25)];
    
    //区域说明
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 100, 300, 60)];
    label.numberOfLines = 0;
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"将条形码或二维码对准下方区域中心";
    label.textColor = [UIColor grayColor];

    [AVCapView addSubview:label];
//    [AVCapView addSubview:cancelBtn];
    
    [self.view addSubview:AVCapView];
    
//
    //画上边框
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop, VIEW_WIDTH- 2 * SCANVIEW_EdgeLeft, 1)];
    topView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:topView];
//
    //画左边框
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop , 1,VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft )];
    leftView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:leftView];
//
//    //画右边框
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft + VIEW_WIDTH- 2 * SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop , 1,VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft + 1)];
    rightView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:rightView];
//
//    //画下边框
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop + VIEW_WIDTH- 2 * SCANVIEW_EdgeLeft,VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft ,1 )];
    downView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:downView];
//
    UIView *_QrCodeline;//上下移动绿色的线条

    //画中间的基准线
    _QrCodeline = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft + 1, SCANVIEW_EdgeTop, VIEW_WIDTH- 2 * SCANVIEW_EdgeLeft - 1, 2)];
    _QrCodeline.backgroundColor = [UIColor greenColor];
    [AVCapView addSubview:_QrCodeline];
//
//
    // 先让基准线运动一次，避免定时器的时差
    [UIView animateWithDuration:1.2 animations:^{

        _QrCodeline.frame = CGRectMake(SCANVIEW_EdgeLeft + 1, VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft + SCANVIEW_EdgeTop , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft - 1, 2);

    }];
////
////
    [self performSelector:@selector(createTimer) withObject:nil afterDelay:0.4];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现定时器
- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

// 滚来滚去
- (void)moveUpAndDownLine
{
    CGFloat YY = _QrCodeline.frame.origin.y;
    
    if (YY != VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft + SCANVIEW_EdgeTop ) {
        [UIView animateWithDuration:1.2 animations:^{
            _QrCodeline.frame = CGRectMake(SCANVIEW_EdgeLeft + 1, VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft + SCANVIEW_EdgeTop , VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft - 1,2);
        }];
    }else {
        [UIView animateWithDuration:1.2 animations:^{
            _QrCodeline.frame = CGRectMake(SCANVIEW_EdgeLeft + 1, SCANVIEW_EdgeTop, VIEW_WIDTH - 2 * SCANVIEW_EdgeLeft - 1,2);
        }];
        
    }
}

//-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    if (metadataObjects.count>0) {
//        //[session stopRunning];
//        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
//        //输出扫描字符串
//        NSLog(@"%@",metadataObject.stringValue);
//        [session stopRunning];
//        [self stopTimer];
//        [AVCapView removeFromSuperview];
//        //.....
//    }
//}

- (void)backhomeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touch{
    
//    act = [UIAlertController alertControllerWithTitle:nil message:@"请选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
    
  
    //  定义图片选择器
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {

            //图片选择是相册（图片来源自相册）

            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

            //设置代理

            picker.delegate=self;

            //模态显示界面

            [self presentViewController:picker animated:YES completion:nil];

        }


  


    
    
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            //图片选择是相册（图片来源自相册）
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //设置代理
            
            picker.delegate=self;
            
            //模态显示界面
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }
        
        else {
            
            NSLog(@"不支持相机");
            
        }
   
    
    
 
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
