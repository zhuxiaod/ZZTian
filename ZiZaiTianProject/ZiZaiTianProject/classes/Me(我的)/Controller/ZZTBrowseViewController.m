//
//  ZZTBrowseViewController.m
//  ZiZaiTianProject
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 zxd. All rights reserved.
//

#import "ZZTBrowseViewController.h"
#import "ZZTTableSwitchView.h"
#import "ZZTCartoonCell.h"
#import "ZZTPlayCell.h"
#import "ZZTChildCollectionView.h"

@interface ZZTBrowseViewController ()<TableSwitchViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger currentIndex;
}
@property (nonatomic,strong) ZZTTableSwitchView *tableSwitchView;
@property (weak, nonatomic) IBOutlet UIScrollView *midView;
@property (nonatomic,strong) UIScrollView *mainScrollView;
//漫画
@property (nonatomic,strong) UICollectionView *cartoonView;
//剧本
@property (nonatomic,strong) ZZTChildCollectionView *playView;

@end

static NSString *collectionID = @"collectionID";
static NSString *collectionViewID = @"collectionViewID";

@implementation ZZTBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置滑动试图
    [self setupMidView];
    //设置主视图
    [self setupMainViews];
    UINib *nib1 = [UINib nibWithNibName:@"ZZTCartoonCell" bundle:nil];
    UINib *nib2 = [UINib nibWithNibName:@"ZZTPlayCell" bundle:nil];

    [self.cartoonView registerNib:nib1 forCellWithReuseIdentifier:collectionID];
    [self.playView  registerNib:nib2 forCellWithReuseIdentifier:collectionViewID];

}
#pragma mark 滑动视图
//设置滑动试图
//大小修改
-(void)setupMidView{
     self.tableSwitchView = [[ZZTTableSwitchView alloc] initWithLeftText:@"漫画" withRightText:@"剧本"];
    __weak typeof(self) weakSelf = self;
    self.tableSwitchView.delegate = weakSelf;
    self.tableSwitchView.frame = CGRectMake(0, 0, Screen_Width, 44);
    [self.midView addSubview:self.tableSwitchView];
}

#pragma mark 流水布局
//将2个页面加入主视图
- (void)setupMainViews{
    //流水布局
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    //创建漫画View
    [self setupCartoonView:layout];
    self.cartoonView.delegate = self;
    self.cartoonView.dataSource = self;
    
    //创建剧本View
    UICollectionViewFlowLayout *layout1 = [self setupCollectionViewFlowLayout];
    [self setupCartoonView:layout1];
    self.playView.delegate = self;
    self.playView.dataSource = self;
    
    [self.midView addSubview:self.mainScrollView];
}
#pragma mark - tableSwitchViewDelegate代理
//选中切换
-(void)tableSwitchView:(ZZTTableSwitchView *)tableSwitchView didSelectedButton:(UIButton *)button forIndex:(NSInteger)index
{
    currentIndex = index;
    [self.mainScrollView setContentOffset:CGPointMake((CGFloat)index * Screen_Width, 0) animated:true];
}

#pragma mark - 控件懒加载
//创建流水布局
-(UICollectionViewFlowLayout *)setupCollectionViewFlowLayout{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(116,200);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //demo
    //    CGFloat margin = (ZXDScreenW - 160) * 0.5;
    //    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    //行距
    layout.minimumLineSpacing = 10;
    return layout;
}

//漫画
-(void)setupCartoonView:(UICollectionViewFlowLayout *)layout{
    _cartoonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, _midView.bounds.size.height - 44) collectionViewLayout:layout];
    _cartoonView.backgroundColor = [UIColor whiteColor];
    _cartoonView.tag = 1001;
    [self.mainScrollView addSubview:self.cartoonView];
}


//剧本
-(void)setupPlayView:(UICollectionViewFlowLayout *)layout{
    _playView= [[ZZTChildCollectionView alloc] initWithFrame:CGRectMake(Screen_Width, 0, Screen_Width, _midView.bounds.size.height - 44) collectionViewLayout:layout];
    _playView.backgroundColor = [UIColor yellowColor];
    _playView.tag = 1002;
    [self.mainScrollView addSubview:self.playView];
}

- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, _midView.bounds.size.height - 44)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = true;
        _mainScrollView.contentSize = CGSizeMake(Screen_Width * 2, 0);
        _mainScrollView.showsVerticalScrollIndicator = false;
        _mainScrollView.showsHorizontalScrollIndicator = false;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.tag = 1000;
    }
    return _mainScrollView;
}
#pragma mark - collectionView代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 1001){
        ZZTCartoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
        cell.bookName.text = @"朱晓丹";
        return cell;
    }else{
        ZZTPlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewID forIndexPath:indexPath];
        cell.name.text = @"朱小丹1111111";
        return cell;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //设置当前被选中的按钮
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * (NSEC_PER_SEC)));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.tableSwitchView clickButtonWithIndex:self->currentIndex];
    });
    
}
@end
