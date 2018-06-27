//
//  ZZTLoginRegisterViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTLoginRegisterViewController.h"
#import "ZXDLoginRegisterView.h"
#import "ZXDFastLoginView.h"

@interface ZZTLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midCons;

@end

@implementation ZZTLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    //登录view
    ZXDLoginRegisterView *loginView = [ZXDLoginRegisterView loginView];
    [self.midView addSubview:loginView];
    
    //注册view
    ZXDLoginRegisterView *registerView = [ZXDLoginRegisterView registerView];
    [self.midView addSubview:registerView];
    
    loginView.buttonAction = ^(UIButton *sender) {
        [self loginButtonClick:sender];
    };

    registerView.buttonAction = ^(UIButton *sender) {
        [self loginButtonClick:sender];
    };
}

-(void)loginButtonClick:(UIButton *)button
{
    //验证码
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"text/xml; charset=ut-8" forHTTPHeaderField:@"Content-Type"];
    
    if (button.tag == 0) {
        //1.创建会话管理者
        //获取验证码
        //http://192.168.0.165:8888/login/sendMsg?phoneNumber=18827514330
        //判断验证码是否够数位
        //如果够 发送  不够 就提示
        [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        NSDictionary *paramDict = @{
                                    @"phoneNumber":@"18827514330"
                                    };
        [manager POST:@"http://192.168.0.165:8888/login/sendMsg" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@---%@",[responseObject class],responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败 -- %@",error);
        }];
    }else{
        //登录
        NSDictionary *paramDict = @{
                                    @"phoneNumber":@"18827514330",
                                    @"checkCode":@"980213"
                                    };
       
        [manager POST:@"http://192.168.0.165:8888/login/loginApp" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@---%@",[responseObject class],responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败 -- %@",error);
        }];
    }
}

-(void)registerButtonClick:(UIButton *)button
{
    
}

// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
-(void)viewDidLayoutSubviews
{
    //一定要调用super
    [super viewDidLayoutSubviews];
    
    ZXDLoginRegisterView *loginView = self.midView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.midView.bounds.size.width * 0.5, self.midView.bounds.size.height);
    
    ZXDLoginRegisterView *registerView = self.midView.subviews[1];
    registerView.frame = CGRectMake(self.midView.bounds.size.width * 0.5, 0, self.midView.bounds.size.width * 0.5, self.midView.bounds.size.height);
}
- (IBAction)dissMiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected =! sender.selected;
    
    //平移中间View
    _midCons.constant = _midCons.constant == 0? -self.midView.bounds.size.width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
