//
//  item.m
//  Best Before
//
//  Created by DMT on 2017/12/12.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "item.h"

@implementation item

- (void)awakeFromNib {
    [super awakeFromNib];
    //cell 点击无背景色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Initialization code
//    _item1.layer.maskedCorners = YES;
    
    _item1.layer.cornerRadius = _item1.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
