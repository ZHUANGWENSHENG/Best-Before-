//
//  ShelflifeTableViewCell.h
//  Best Before
//
//  Created by DMT on 2017/12/23.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShelflifeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *shelflifeyear;
@property (weak, nonatomic) IBOutlet UITextField *shelflifemonth;
@property (weak, nonatomic) IBOutlet UITextField *shelflifeday;

@end
