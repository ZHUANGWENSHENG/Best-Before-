//
//  item.h
//  Best Before
//
//  Created by DMT on 2017/12/12.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface item : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *item1;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *shengyu;

@end
