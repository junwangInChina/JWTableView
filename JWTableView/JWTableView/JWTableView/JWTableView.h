//
//  JWTableView.h
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JWTableLoadingView.h"
#import "JWTableErrorView.h"
#import "JWTableEmptyView.h"

/**
 *  表格状态枚举，加载中、空、加载失败
 */
typedef NS_ENUM(NSInteger, JWTableViewState) {
    JWTableViewStateLoading = 1,
    JWTableViewStateEmpty,
    JWTableViewStateError
};

/**
 *  表格加载失败，点击触发重新加载的block
 */
typedef void(^JWTableErrorLoadHandler)(void);

/**
 *  数据为空，点击触发的block
 */
typedef void(^JWTableEmptyLoadHandler)(void);

@interface JWTableView : UITableView

@property (nonatomic, copy) JWTableErrorLoadHandler errorHandler;

@property (nonatomic, copy) JWTableEmptyLoadHandler emptyHandler;

@property (nonatomic, assign) CGFloat emptyTopMargin;
@property (nonatomic, assign) CGFloat errorTopMargin;
@property (nonatomic, assign) CGFloat loadingTopMargin;
@property (nonatomic, strong) UIColor *emptyBgColor;
@property (nonatomic, strong) UIColor *errorBgColor;
@property (nonatomic, strong) UIColor *loadingBgColor;

/**
 *  配置自定义的三种状态View，需要继承JWTableLoadingView、JWTableEmptyView、JWTableErrorView
 *
 *  @param loadingView 自定义的LoadingView，继承于JWTableLoadingView
 *  @param emptyView   自定义的EmptyView，继承于JWTableEmptyView
 *  @param errorView   自定义的ErrorView，继承于JWTableErrorView
 */
- (void)configLoadingView:(JWTableLoadingView *)loadingView
                emptyView:(JWTableEmptyView *)emptyView
                errorView:(JWTableErrorView *)errorView;

/**
 *  配置默认LoadingView的数据
 *
 *  @param title     LoadingView的Title
 *  @param imageName LoadingView的图片
 */
- (void)configLoadingTitle:(NSString *)title
                     image:(NSString *)imageName;

/**
 *  配置默认EmptyView的数据
 *
 *  @param title     EmptyView的Title
 */
- (void)configEmptyTitle:(NSString *)title;

/**
 *  配置默认EmptyView的数据
 *
 *  @param title          EmptyView的Title
 *  @param imageName      EmptyView的图片
 *  @param handlerTitle   EmptyView的触发回调按钮标题
 */
- (void)configEmptyTitle:(NSString *)title
                   image:(NSString *)imageName
                 handler:(NSString *)handlerTitle;

/**
 *  配置默认ErrorView的数据
 *
 *  @param title          ErrorView的Title
 *  @param imageName      ErrorView的图片
 *  @param handlerTitle   ErrorView的触发回调按钮标题
 */
- (void)configErrorTitle:(NSString *)title
                   image:(NSString *)imageName
                 handler:(NSString *)handlerTitle;

/**
 *  设置表格展示状态View
 *
 *  @param shouldShow  展示or隐藏
 *  @param state       状态
 */
- (void)setStateViewShow:(BOOL)shouldShow withState:(JWTableViewState)state;

/**
 *  配置一个空的FootView，用于遮挡没有数据的行
 */
- (void)configZeroFootView;

/**
 *  配置自定义的分割线
 */
- (void)configCustomSeparator;

@end
