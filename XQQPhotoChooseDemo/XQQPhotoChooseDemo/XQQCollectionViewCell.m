//
//  XQQCollectionViewCell.m
//  XQQPhotoChooseDemo
//
//  Created by XQQ on 16/8/17.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQCollectionViewCell.h"


@interface XQQCollectionViewCell()

/**
 * 是否显示选择的imageView
 */
@property (nonatomic, assign)  BOOL  isShowPic;
/**
 * 记录按钮点击
 */
@property (nonatomic, assign)  BOOL   isImagePressed;


@end

@implementation XQQCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isShowPic = NO;
        _isImagePressed = NO;
        self.backgroundColor = [UIColor yellowColor];
        //上部imageView
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _picImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * picTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewDidSel)];
        [_picImageView addGestureRecognizer:picTap];
        //下部背景view
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
//        _backView.backgroundColor = [UIColor blueColor];
        //选择的imageView
        _selImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backView.frame.size.width - 30, 0, 30, 30)];
        _selImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * selTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewDidSel)];
        [_selImageView addGestureRecognizer:selTap];
        _selImageView.layer.cornerRadius = 15;
        _selImageView.layer.masksToBounds = YES;
        _selImageView.backgroundColor = [UIColor grayColor];
        _selImageView.alpha = 0.6;
        [_backView addSubview:_selImageView];
        [_picImageView addSubview:_backView];
        _backView.hidden = YES;
        [self.contentView addSubview:_picImageView];
    }
    return self;
}

- (void)imageViewDidSel{
    //多选时候点击
    if (_isShowPic) {
        if (_isImagePressed) {
            _selImageView.backgroundColor = [UIColor grayColor];
            _didSel(NO);
            _isImagePressed = NO;
        }else{
            _selImageView.backgroundColor = [UIColor redColor];
            _didSel(YES);
            _isImagePressed = YES;
        }
    }else{
        //不是多选时候点击  放大
        
    }
}


- (void)loadDataWithModel:(XQQCollectionModel*)model{
    _picImageView.image = [UIImage imageNamed:model.picName];
    if (model.isSelImageViewShow) {
        if (model.isPicSel) {
            _selImageView.backgroundColor = [UIColor redColor];
            _isImagePressed = YES;
        }else{
            _selImageView.backgroundColor = [UIColor grayColor];
            _isImagePressed = NO;
        }
        _backView.hidden = NO;
         _isShowPic = YES;
    }else{
        _backView.hidden = YES;
        _isShowPic = NO;
    }
}

@end
