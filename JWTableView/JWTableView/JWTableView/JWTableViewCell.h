//
//  JWTableViewCell.h
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

struct JWSeparatorInsert
{
    CGFloat forwardInsert;
    CGFloat backwardInsert;
};

typedef struct JWSeparatorInsert JWSeparatorInsert;

CG_INLINE JWSeparatorInsert
JWSeparatorInsertMake(CGFloat forwardInsert, CGFloat backwardInsert)
{
    JWSeparatorInsert insert;
    insert.forwardInsert = forwardInsert;
    insert.backwardInsert = backwardInsert;
    return insert;
}
CG_INLINE JWSeparatorInsert JWSeparatorInsertMake(CGFloat forwardInsert, CGFloat backwardInsert);

@interface JWTableViewCell : UITableViewCell

/**
 *  配置是否适用自定义的表格分割线
 *
 *  @param useCustomSeparator 是否使用，默认NO
 *  @param separatorColor     分割线颜色，默认[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]
 */
- (void)configCustomSeparator:(BOOL)useCustomSeparator
                        color:(UIColor *)separatorColor;

/**
 *  配置定制的表格分割线缩进效果
 *
 *  @param commonInsert 通用的缩进效果     默认
 *  @param lastInsert   最后一行的缩进效果
 */
- (void)configCommonSeparatorInsert:(JWSeparatorInsert)commonInsert
                lastSeparatorInsert:(JWSeparatorInsert)lastInsert;

/**
 *  指定Cell是否是最后一个Cell
 *
 *  @param isLast 是否是最后一行
 */
- (void)isLastCell:(BOOL)isLast;

@end
