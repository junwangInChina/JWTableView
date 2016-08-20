//
//  JWTableLoadingView.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableLoadingView.h"

#import <Masonry/Masonry.h>

@interface JWTableLoadingView()

@property (nonatomic, strong) UILabel *loadingLabel;
@property (nonatomic, strong) UIImageView *loadingImageView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingActivity;

@end

@implementation JWTableLoadingView

#pragma mark - Life cycle
- (void)dealloc
{
    self.loadingLabel = nil;
    self.loadingImageView = nil;
    self.loadingActivity = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    __weak __typeof(self)this = self;
    [self.loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.centerY.equalTo(this.mas_centerY).with.multipliedBy(0.5);
    }];
    
    [self.loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(this.mas_centerY).with.offset(-20);
        make.centerX.equalTo(this).with.offset(20);
    }];
    
    [self.loadingActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(this.loadingLabel);
        make.right.equalTo(this.loadingLabel.mas_left).with.offset(-10);
    }];
}

#pragma mark - Lazy loading
- (UILabel *)loadingLabel
{
    if (!_loadingLabel)
    {
        self.loadingLabel = [UILabel new];
        _loadingLabel.textAlignment = NSTextAlignmentLeft;
        _loadingLabel.backgroundColor = self.backgroundColor;
        _loadingLabel.font = [UIFont systemFontOfSize:15];
        _loadingLabel.numberOfLines = 0;
        _loadingLabel.textColor = [UIColor lightGrayColor];
        _loadingLabel.text = @"加载中...";
        [self addSubview:_loadingLabel];
    }
    return _loadingLabel;
}

- (UIImageView *)loadingImageView
{
    if (!_loadingImageView)
    {
        self.loadingImageView = [UIImageView new];
        _loadingImageView.backgroundColor = self.backgroundColor;
        [self addSubview:_loadingImageView];
    }
    return _loadingImageView;
}

- (UIActivityIndicatorView *)loadingActivity
{
    if (!_loadingActivity)
    {
        self.loadingActivity = [[UIActivityIndicatorView alloc] init];
        _loadingActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_loadingActivity startAnimating];
        [self addSubview:_loadingActivity];
    }
    return _loadingActivity;
}

#pragma mark - Public Method
- (void)configLoadingLog:(NSString *)loadingLog
                   image:(NSString *)imageName
{
    if (loadingLog.length > 0)
    {
        self.loadingLabel.text = loadingLog;
    }
    if (imageName.length > 0)
    {
        self.loadingImageView.image = [UIImage imageNamed:imageName];
    }
}

@end
