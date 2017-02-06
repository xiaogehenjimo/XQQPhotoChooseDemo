//
//  XQQCollectionModel.h
//  XQQPhotoChooseDemo
//
//  Created by XQQ on 16/8/17.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQQCollectionModel : NSObject
/**
 *  图片的名字
 */
@property (nonatomic, copy)  NSString  *  picName;
/**
 *  是否显示选择的标记按钮
 */
@property(nonatomic, assign)  BOOL   isSelImageViewShow;
/**
 *  记录自身是否被选中
 */
@property(nonatomic, assign)  BOOL   isPicSel;



@end
