//
//  ZZTMeTopView.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeTopView.h"
@interface ZZTMeTopView ()

@property (weak, nonatomic) IBOutlet UIButton *zBiButton;
@property (weak, nonatomic) IBOutlet UIButton *integralButton;
@property (weak, nonatomic) IBOutlet UIButton *readTicket;
@property (weak, nonatomic) IBOutlet UIImageView *userHead;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation ZZTMeTopView 

+(instancetype)meTopView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [self.zBiButton setTitle:@"5000 \nZ币" forState:UIControlStateNormal];
    self.zBiButton.titleLabel.lineBreakMode = 0;
    [self.integralButton setTitle:@"500 \n积分" forState:UIControlStateNormal];
    self.zBiButton.titleLabel.lineBreakMode = 0;
    [self.readTicket setTitle:@"500 \n阅读卷" forState:UIControlStateNormal];
    self.zBiButton.titleLabel.lineBreakMode = 0;
    self.userHead.image = [UIImage imageNamed:@"peien"];
    self.userHead.layer.cornerRadius = self.userHead.frame.size.width/2;
    self.userHead.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    self.userHead.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userHead.layer.borderWidth = 1.0f;
    self.userName.text = @"佩恩";
    
    
}

- (void)buttonClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
    }
}

@end
