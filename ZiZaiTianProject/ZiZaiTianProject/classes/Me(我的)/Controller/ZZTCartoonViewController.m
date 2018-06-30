//
//  ZZTCartoonViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTCartoonViewController.h"
#import "ZZTCartoonCell.h"
//请求192.168.0.165:8888/great/daiti?id=daiti
@interface ZZTCartoonViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) EncryptionTools *encryptionManager;
//获得数据
@property (nonatomic,strong) NSString *getData;
//cartoons
@property (nonatomic,strong) NSArray *cartoons;
@end


@implementation ZZTCartoonViewController

#pragma mark - 懒加载
- (EncryptionTools *)encryptionManager{
    if(!_encryptionManager){
        _encryptionManager = [EncryptionTools sharedEncryptionTools];
    }
    return _encryptionManager;
}

- (NSArray *)cartoons{
    if (!_cartoons) {
        _cartoons = [NSArray array];
    }
    return _cartoons;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString *collectionID = @"collectionID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //流水布局
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];

    //创建UICollectionView：黑色
    [self setupCollectionView:layout];
    //注册cell
    UINib *nib = [UINib nibWithNibName:@"ZZTCartoonCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:collectionID];
    
    //加载数据
    [self loadData];
}

-(void)loadData{
    //请求参数
    NSLog(@"dataIndex:%@",self.dataIndex);
    NSDictionary *paramDict = @{
                                @"userId":@"1",
                                @"type":self.dataIndex
                                };
    [self.manager POST:@"http://192.168.0.165:8888/great/userCollect" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@---%@",[responseObject class],responseObject);
        self.getData = responseObject[@"result"];
        //成功运行的方法
        [self decry];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败 -- %@",error);
    }];
}

//请求到数据了
-(void)decry{
    //解密
    NSString *data = [self.encryptionManager decryptString:self.getData keyString:@"ZIZAITIAN@666666" iv:[@"A-16-Byte-String" dataUsingEncoding:kCFStringEncodingUTF8]];
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"data:%@",data);
    //转模型
    NSArray *books = [ZZTCartonnPlayModel mj_objectArrayWithKeyValuesArray:dic];
    self.cartoons = books;
    //刷新
    [self.collectionView reloadData];
}

#pragma mark - 创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(120,200);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //行距
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 5;
    
    return layout;
}

#pragma mark - 创建CollectionView
-(void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cartoons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    ZZTCartonnPlayModel *car = self.cartoons[indexPath.row];
    if (car) {
        cell.cartoon = car;
    }
    return cell;
}
@end
