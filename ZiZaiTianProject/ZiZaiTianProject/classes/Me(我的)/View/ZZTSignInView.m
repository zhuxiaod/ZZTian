//
//  ZZTSignInView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/7/2.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTSignInView.h"
#import "ZZTSignButton.h"

@interface ZZTSignInView()
@property(nonatomic,strong) NSMutableArray *btns;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day1;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day2;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day3;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day4;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day5;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day6;
@property (weak, nonatomic) IBOutlet ZZTSignButton *day7;
@property(nonatomic,assign) int i;

@end
@implementation ZZTSignInView

-(NSMutableArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray array];
    }
    return _btns;
}

+(instancetype)SignView{
    //btn赋值

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
 
    [self.btns  addObject:_day1];
    [self.btns  addObject:_day2];
    [self.btns  addObject:_day3];
    [self.btns  addObject:_day4];
    [self.btns  addObject:_day5];
    [self.btns  addObject:_day6];
    [self.btns  addObject:_day7];
    for (NSInteger i = 0; i < 7; i++) {
        ZZTSignButton *btn = self.btns[i];
        btn.isGet = NO;
        btn.titleLabel.text = @"领取";
        btn.ifSign = NO;
    }
}

//给btn传值
-(void)isget:(NSInteger)signCount isSign:(NSInteger)isSign{

    for (NSInteger i = 0;i < signCount;i++) {
        ZZTSignButton *btn = self.btns[i];
        btn.isGet = YES;
        btn.titleLabel.text = @"已领";
    }
    signCount = signCount+1;
    if (isSign == 1) {
        ZZTSignButton *btn = _btns[signCount];
        btn.ifSign = YES;
    }
}
@end
