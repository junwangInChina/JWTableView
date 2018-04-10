//
//  JWTableView.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableView.h"

#import <Masonry/Masonry.h>

@interface JWTableView()

@property (nonatomic, strong) JWTableLoadingView *loadingView;
@property (nonatomic, strong) JWTableEmptyView *emptyView;
@property (nonatomic, strong) JWTableErrorView *errorView;

@end

@implementation JWTableView

#pragma mark - Life cycle
- (void)dealloc
{
    self.loadingView = nil;
    self.emptyView = nil;
    self.errorView = nil;
    self.errorHandler = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self configLoadingView:nil emptyView:nil errorView:nil];
    }
    return self;
}

#pragma mark - Lazy loading

- (JWTableLoadingView *)loadingView
{
    if (!_loadingView)
    {
        self.loadingView = [[JWTableLoadingView alloc] init];
        
    }
    return _loadingView;
}

- (JWTableEmptyView *)emptyView
{
    if (!_emptyView)
    {
        self.emptyView = [[JWTableEmptyView alloc] init];
    }
    return _emptyView;
}

- (JWTableErrorView *)errorView
{
    if (!_errorView)
    {
        self.errorView = [[JWTableErrorView alloc] init];
    }
    return _errorView;
}

- (void)setErrorHandler:(JWTableErrorLoadHandler)errorHandler
{
    _errorHandler = errorHandler;
    self.errorView.errorHandler = errorHandler;
}

- (void)setEmptyHandler:(JWTableEmptyLoadHandler)emptyHandler
{
    _emptyHandler = emptyHandler;
    self.emptyView.emptyHandler = emptyHandler;
}

#pragma mark - Public Method
- (void)configLoadingView:(JWTableLoadingView *)loadingView
                emptyView:(JWTableEmptyView *)emptyView
                errorView:(JWTableErrorView *)errorView
{
    if (loadingView)
    {
        self.loadingView = loadingView;
    }
    if (emptyView)
    {
        self.emptyView = emptyView;
    }
    if (errorView)
    {
        self.errorView = errorView;
    }
    self.emptyTopMargin = 0;
}

- (void)configLoadingTitle:(NSString *)title
                     image:(NSString *)imageName
{
    [self.loadingView configLoadingLog:title
                                 image:imageName];
}

- (void)configEmptyTitle:(NSString *)title
{
    [self.emptyView configEmptyLog:title];
}

- (void)configEmptyTitle:(NSString *)title
                   image:(NSString *)imageName
                 handler:(NSString *)handlerTitle
{
    [self.emptyView configEmptyLog:title
                        emptyImage:imageName
                      emptyHandler:handlerTitle];
}

- (void)configErrorTitle:(NSString *)title
                   image:(NSString *)imageName
                 handler:(NSString *)handlerTitle
{
    [self.errorView configErrorLog:title
                        errorImage:imageName
                      errorHandler:handlerTitle];
}

- (void)configZeroFootView
{
    self.tableFooterView = [UIView new];
}

- (void)configCustomSeparator
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setStateViewShow:(BOOL)shouldShow withState:(JWTableViewState)state
{
    if (shouldShow)
    {
        switch (state) {
            case JWTableViewStateLoading:
                [self setLoadingViewShow:shouldShow];
                break;
            case JWTableViewStateEmpty:
                [self setEmptyViewShow:shouldShow];
                break;
            case JWTableViewStateError:
                [self setErrorViewShow:shouldShow];
                break;
            default:
                break;
        }
    }
    else
    {
        [self clearAllStateView];
        
        self.scrollEnabled = YES;
    }
}

#pragma mark - Private Method
- (void)setLoadingViewShow:(BOOL)shouldShow
{
    if (self.emptyView)
    {
        [self.emptyView removeFromSuperview];
    }
    if (self.errorView)
    {
        [self.errorView removeFromSuperview];
    }
    if (self.loadingView)
    {
        self.loadingView.backgroundColor = self.backgroundColor;
        [self addSubview:self.loadingView];
        
        __weak __typeof(self)weakSelf = self;
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsZero);
            make.size.equalTo(weakSelf);
        }];
        
        self.scrollEnabled = NO;
    }
}

- (void)setEmptyViewShow:(BOOL)shouldShow
{
    if (self.loadingView)
    {
        [self.loadingView removeFromSuperview];
    }
    if (self.errorView)
    {
        [self.errorView removeFromSuperview];
    }
    if (self.emptyView)
    {
        self.emptyView.backgroundColor = self.backgroundColor;
        [self addSubview:self.emptyView];
        
        __weak __typeof(self)weakSelf = self;
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf).with.offset(weakSelf.emptyTopMargin);
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width,
                                             weakSelf.frame.size.height - weakSelf.emptyTopMargin));
        }];
        self.scrollEnabled = NO;
    }
}

- (void)setErrorViewShow:(BOOL)shouldShow
{
    if (self.loadingView)
    {
        [self.loadingView removeFromSuperview];
    }
    if (self.emptyView)
    {
        [self.emptyView removeFromSuperview];
    }
    if (self.errorView)
    {
        self.errorView.backgroundColor = self.backgroundColor;
        [self addSubview:self.errorView];
        
        __weak __typeof(self)weakSelf = self;
        [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsZero);
            make.size.equalTo(weakSelf);
        }];
        
        self.scrollEnabled = NO;
    }
}

- (void)clearAllStateView
{
    [self.loadingView removeFromSuperview];
    [self.emptyView removeFromSuperview];
    [self.errorView removeFromSuperview];
}

@end
