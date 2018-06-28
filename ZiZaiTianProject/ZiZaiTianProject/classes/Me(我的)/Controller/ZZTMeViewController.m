//
//  ZZTMeViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTMeViewController.h"
#import "ZZTMeTopView.h"
#import "ZZTMeCell.h"
#import "ZZTSettingCell.h"
#import "MJExtension.h"
#import "ZZTCell.h"
#import "ZZTLoginRegisterViewController.h"
#import "ZZTVIPViewController.h"
#import "ZZTBrowseViewController.h"

@interface ZZTMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong) UITableView *tableView;
//cell数据
@property (nonatomic, strong) NSArray *cellData;

@end

@implementation ZZTMeViewController

//cell的标识
NSString *bannerID = @"MeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    [self getData];
    //设置table
    [self setupTab];
}

#pragma mark - 请求数据
-(void)getData{
    
  
}

#pragma mark - 设置tableView
-(void)setupTab
{
    //创建静态的tableView
//    _tableView.backgroundColor = [UIColor colorWithHexString:@"#58006E"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.sectionHeaderHeight = 10;
    _tableView.sectionFooterHeight = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //行高
//    _tableView.rowHeight = 50;
    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    //添加头视图
    ZZTMeTopView *top = [ZZTMeTopView meTopView];
    _tableView.tableHeaderView = top;
    [self.view addSubview:_tableView];
    //注册cell
    [self.tableView registerClass:[ZZTMeCell class] forCellReuseIdentifier:bannerID];
    top.buttonAction = ^(UIButton *sender) {
        [self buttonClick:sender];
    };
}


-(void)buttonClick:(UIButton *)button{
    if (button.tag == 0) {
        NSLog(@"我是z币");
    }else if(button.tag == 1){
        NSLog(@"我是积分");
    }else if(button.tag == 2){
        NSLog(@"我是票");
    }
    else if(button.tag == 3){
        NSLog(@"我是消息");
    }
    else if(button.tag == 4){
        
        ZZTLoginRegisterViewController *loginView = [[ZZTLoginRegisterViewController alloc]initWithNibName:@"ZZTLoginRegisterViewController" bundle:nil];
        [self presentViewController:loginView animated:YES completion:nil];

    }else{
        NSLog(@"我是签到");
    }
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 2;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }else if (section == 3){
        return 3;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTMeCell *cell = [tableView dequeueReusableCellWithIdentifier:bannerID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的VIP";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"我的钱包";
        }
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"自在商城";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"积分兑换";
        }
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的帖子";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"我的圈子";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"我的关注";
        }
        return cell;
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"参与作品";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"我的收藏";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"浏览历史";
        }
        return cell;
    }else{
        cell.textLabel.text = @"设置";
        return cell;
    }
    return cell;
}
//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            ZZTVIPViewController *VIPView = [[ZZTVIPViewController alloc]init];
            VIPView.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:VIPView animated:YES];
        }
    }else if(indexPath.section == 3){
        if(indexPath.row == 1){
            ZZTBrowseViewController *browse = [[ZZTBrowseViewController alloc] init];
            browse.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:browse animated:YES];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏Bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
