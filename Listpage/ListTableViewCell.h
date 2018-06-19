//
//  ListTableViewCell.h
//  Best Before
//
//  Created by DMT on 2017/12/25.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *Listcell;
@property (weak, nonatomic) IBOutlet UIView *list;
@property (weak, nonatomic) IBOutlet UILabel *shuliang;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
