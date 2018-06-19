//
//  RemindTableViewCell.m
//  Best Before
//
//  Created by DMT on 2017/12/23.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "RemindTableViewCell.h"

@implementation RemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _reminddate.delegate=self;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
