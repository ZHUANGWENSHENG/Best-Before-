//
//  addTableViewCell.m
//  Best Before
//
//  Created by DMT on 2017/12/19.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "addTableViewCell.h"

@implementation addTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_name resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

@end
