//
//  ZZTSignButton.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSignButton.h"

@implementation ZZTSignButton

-(void)setIsGet:(BOOL)isGet{
    _isGet = isGet;
    if(isGet == NO){
        self.backgroundColor = [UIColor grayColor];
        [self setTitle:@"22" forState:UIControlStateNormal];
    }else{
        self.backgroundColor = [UIColor yellowColor];
        [self setTitle:@"33" forState:UIControlStateNormal];
    }
}

@end
