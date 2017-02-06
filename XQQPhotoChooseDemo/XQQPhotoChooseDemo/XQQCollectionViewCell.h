//
//  XQQCollectionViewCell.h
//  XQQPhotoChooseDemo
//
//  Created by XQQ on 16/8/17.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQQCollectionModel.h"

typedef void(^cellDidSel)(BOOL isSel);

@interface XQQCollectionViewCell : UICollectionViewCell
/**
 *  上部imageView
 */
@property(nonatomic, strong)  UIImageView  *  picImageView;
/**
 *  选择的背景View
 */
@property(nonatomic, strong)  UIView  *  backView;
/**
 *  右侧选择的imageView
 */
@property(nonatomic, strong)  UIImageView  *  selImageView;
/**
 *  block
 */
@property (nonatomic, copy)  cellDidSel    didSel;

- (void)loadDataWithModel:(XQQCollectionModel*)model;

@end
