//
//  UILabel+TextAlign.m
//  Best Before
//
//  Created by Patatas on 2017/12/25.
//  Copyright © 2017年 Patatas. All rights reserved.
//

#import "UILabel+TextAlign.h"

@implementation UILabel (TextAlign)

-(void)setIsTop:(BOOL)isTop {
    
    if (isTop) {
        CGSize fontSize = [self.text sizeWithFont:self.font];
        //控件的高度除以一行文字的高度
        int num = self.frame.size.height/fontSize.height;
        //计算需要添加换行符个数
        int newLinesToPad = num - self.numberOfLines;
        self.numberOfLines = 0;
        for(int i=0; i<newLinesToPad; i++)
            //在文字后面添加换行符"/n"
            self.text = [self.text stringByAppendingString:@"\n"];
    }
}

-(void)setIsBottom:(BOOL)isBottom {
    
    if (isBottom) {
        CGSize fontSize = [self.text sizeWithFont:self.font];
        //控件的高度除以一行文字的高度
        int num = self.frame.size.height/fontSize.height;
        //计算需要添加换行符个数
        int newLinesToPad = num  - self.numberOfLines;
        self.numberOfLines = 0;
        for(int i=0; i<newLinesToPad; i++)
            //在文字前面添加换行符"/n"
            self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

@end
