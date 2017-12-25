//
//  TextFieldView.m
//  MovoTextFieldToNavBar
//
//  Created by 王少帅 on 2017/12/25.
//  Copyright © 2017年 王少帅. All rights reserved.
//


#import "TextFieldView.h"

@implementation TextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索"]];
        [self addSubview:imgView];
        imgView.frame = CGRectMake(8, 8, 44-7-7-8-8, 44-7-7-8-8);
        
    }
    return self;
}

@end
