//
//  ListTableViewCell.m
//  Best Before
//
//  Created by DMT on 2017/12/25.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //cell 点击无背景色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Initialization code
    
    //button
    _list.layer.cornerRadius = _list.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
