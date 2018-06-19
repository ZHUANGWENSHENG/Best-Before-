//
//  ProducedTableViewCell.h
//  Best Before
//
//  Created by DMT on 2017/12/23.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProducedTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *produced;

@end

