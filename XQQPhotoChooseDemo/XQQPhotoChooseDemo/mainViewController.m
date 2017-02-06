//
//  mainViewController.m
//  XQQPhotoChooseDemo
//
//  Created by XQQ on 16/8/17.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "mainViewController.h"
#import "XQQCollectionModel.h"
#import "XQQCollectionViewCell.h"

#define iphoneWidth  [UIScreen mainScreen].bounds.size.width
#define iphoneHeight [UIScreen mainScreen].bounds.size.height
@interface mainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  photot数据源
 */
@property (nonatomic, strong) NSMutableArray * dataArr;
/**
 *  collectionView
 */
@property(nonatomic, strong)  UICollectionView  *  collectionView;
/**
 *  记录图片选择
 */
@property(nonatomic, assign)  BOOL   isPhotoSel;
/**
 *  记录选择按钮是否点击
 */
@property(nonatomic, assign)  BOOL   isSelBtnPress;
/**
 *  右上角选择按钮
 */
@property(nonatomic, strong)  UIBarButtonItem  *  rightSelItem;
/**
 *  记录下方多选view是否显示
 */
@property(nonatomic, assign)  BOOL   isAllSelPress;
/**
 *  多选的View
 */
@property(nonatomic, strong)  UIView  *  allSelBackView;
/**
 *  多选按钮
 */
@property(nonatomic, strong)  UIButton  *  allSelBtn;
/**
 *  记录是否全选
 */
@property(nonatomic, assign)  BOOL   isAllSelBtn;
/**
 *  删除按钮
 */
@property(nonatomic, strong)  UIButton  *  deleteBtn;
/**
 *  确定按钮
 */
@property(nonatomic, strong)  UIButton  *  enterBtn;

@end


@implementation mainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _isSelBtnPress = NO;
    _isAllSelBtn = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = self.rightSelItem;
    //组织数据源
    for (NSInteger i = 0; i < 28; i ++) {
        XQQCollectionModel * model = [[XQQCollectionModel alloc]init];
        model.picName = [NSString stringWithFormat:@"%ld.jpg",i];
        model.isSelImageViewShow = NO;
        model.isPicSel = NO;
        [self.dataArr addObject:model];
    }
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.allSelBackView];
}
#pragma mark - activity
- (void)itemDidPress{
    if (_isSelBtnPress) {
        self.rightSelItem.title = @"选择";
        for (XQQCollectionModel * model in self.dataArr) {
            model.isSelImageViewShow = NO;
            model.isPicSel = NO;
        }
        [self.collectionView reloadData];
        _allSelBackView.hidden = YES;
        _isSelBtnPress = NO;
        [self.allSelBtn setTitle:@"全选" forState:UIControlStateNormal];
        _isAllSelBtn = NO;
    }else{
        self.rightSelItem.title = @"取消选择";
        for (XQQCollectionModel * model in self.dataArr) {
            model.isSelImageViewShow = YES;
            model.isPicSel = NO;
        }
        [self.collectionView reloadData];
        _allSelBackView.hidden = NO;
        _isSelBtnPress = YES;
    }
}
- (void)buttonDidSel:(UIButton*)button{
  
    switch (button.tag) {
        case 10:
        {
            if (_isAllSelBtn) {
                //取消全选
                for (XQQCollectionModel * model in self.dataArr) {
                    model.isPicSel = NO;
                }
                [self.collectionView reloadData];
                [self.allSelBtn setTitle:@"全选" forState:UIControlStateNormal];
                _isAllSelBtn = NO;
            }else{
                //全选
                for (XQQCollectionModel * model in self.dataArr) {
                    model.isPicSel = YES;
                }
                [self.collectionView reloadData];
                [self.allSelBtn setTitle:@"取消全选" forState:UIControlStateNormal];
                _isAllSelBtn = YES;
            }
        }
            break;
            case 11:
        {
            //确定
            NSMutableArray * tmpSelArr = @[].mutableCopy;
            for (XQQCollectionModel * model in self.dataArr) {
                if (model.isPicSel) {
                    [tmpSelArr addObject:model];
                }
            }
            if (tmpSelArr.count <= 0 ) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择图片" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                //做下一步事情 选择结束
#warning will to do ...
            }
        }
            break;
            case 12:
        {
            //删除
            NSMutableArray * tmpArr = @[].mutableCopy;
            for (XQQCollectionModel * model in self.dataArr) {
                if (model.isPicSel) {
                    [tmpArr addObject:model];
                }
            }
            if (tmpArr.count <= 0 ) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未选中任何项目" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                [self.dataArr removeObjectsInArray:tmpArr];
                [self.collectionView reloadData];
                [tmpArr removeAllObjects];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XQQCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coll" forIndexPath:indexPath];
    XQQCollectionModel * model = self.dataArr[indexPath.row];
    [cell loadDataWithModel:model];
    cell.didSel = ^(BOOL isSel){
        if (isSel) {
            //选中了
            model.isPicSel = YES;
        }else{
            model.isPicSel = NO;
        }
    };
    return cell;
}

#pragma mark - setter&getter
- (UIView *)allSelBackView{
    if (!_allSelBackView) {
        _allSelBackView = [[UIView alloc]initWithFrame:CGRectMake(0, iphoneHeight - 40, iphoneWidth, 40)];
        _allSelBackView.backgroundColor = [UIColor grayColor];
        _allSelBackView.alpha = 0.8;
        _allSelBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 75, 30)];
        _allSelBtn.tag = 10;
        [_allSelBtn addTarget:self action:@selector(buttonDidSel:) forControlEvents:UIControlEventTouchUpInside];
        [_allSelBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(iphoneWidth/2-30, 5, 60, 30)];
        _enterBtn.tag = 11;
        [_enterBtn addTarget:self action:@selector(buttonDidSel:) forControlEvents:UIControlEventTouchUpInside];
        [_enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_allSelBackView.frame.size.width - 65, 0, 60, 30)];
        _deleteBtn.tag = 12;
        [_deleteBtn addTarget:self action:@selector(buttonDidSel:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_allSelBackView addSubview:_allSelBtn];
        [_allSelBackView addSubview:_enterBtn];
        [_allSelBackView addSubview:_deleteBtn];
        _allSelBackView.hidden = YES;
    }
    return _allSelBackView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小为200*300
        layout.itemSize = CGSizeMake((iphoneWidth-30)/3, 150);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //通过一个布局创建collectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[XQQCollectionViewCell class] forCellWithReuseIdentifier:@"coll"];
    }
    return _collectionView;
}
- (UIBarButtonItem *)rightSelItem{
    if (!_rightSelItem) {
        _rightSelItem = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(itemDidPress)];
    }
    return _rightSelItem;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
