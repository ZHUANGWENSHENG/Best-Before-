//
//  ProducedTableViewCell.m
//  Best Before
//
//  Created by DMT on 2017/12/23.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "ProducedTableViewCell.h"

@implementation ProducedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _produced.delegate=self;
    

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
};
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
