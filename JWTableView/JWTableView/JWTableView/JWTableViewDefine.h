//
//  JWTableViewDefine.h
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#ifndef JWTableViewDefine_h
#define JWTableViewDefine_h

#import "JWTableView.h"
#import "JWTableLoadingView.h"
#import "JWTableEmptyView.h"
#import "JWTableErrorView.h"
#import "JWTableViewCell.h"

#define JW_PLUS_HEIGHT 736.0

#define JW_PLUS_WIDTH  414.0

#define JW_WIDTH_TRANSF(width) (((width)/JW_PLUS_WIDTH)*JW_SCREEN_WIDTH)

#define JW_HEIGHT_TRANSF(height) (((height)/JW_PLUS_HEIGHT)*JW_SCREEN_HEIGHT)

#define JW_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define JW_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#endif /* JWTableViewDefine_h */
