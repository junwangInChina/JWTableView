//
//  JWTableErrorView.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableErrorView.h"

#import "JWTableViewDefine.h"

#import <Masonry/Masonry.h>

@interface JWTableErrorView()

@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UIButton *errorButton;

@end

@implementation JWTableErrorView

#pragma mark - Life cycle
- (void)dealloc
{
    self.errorLabel = nil;
    self.errorImageView = nil;
    self.errorHandler = nil;
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
    [self.errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(415.0/3));
    }];
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(705.0/3));
    }];
    
    [self.errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(860.0/3));
        make.size.mas_equalTo(CGSizeMake(800.0/3, 50));
    }];
}

#pragma mark - Lazy loading
- (UILabel *)errorLabel
{
    if (!_errorLabel)
    {
        self.errorLabel = [UILabel new];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.backgroundColor = self.backgroundColor;
        _errorLabel.font = [UIFont fontWithName:@"Arial" size:14];
        _errorLabel.numberOfLines = 0;
        _errorLabel.textColor = [UIColor colorWithRed:74/255.0 green:76/255.0 blue:91/255.0 alpha:1.0];
        _errorLabel.text = @"请求失败，点击屏幕重新请求!";
        [self addSubview:_errorLabel];
    }
    return _errorLabel;
}

- (UIImageView *)errorImageView
{
    if (!_errorImageView)
    {
        self.errorImageView = [UIImageView new];
        _errorImageView.backgroundColor = self.backgroundColor;
        [self addSubview:_errorImageView];
    }
    return _errorImageView;
}

- (UIButton *)errorButton
{
    if (!_errorButton)
    {
        self.errorButton = [UIButton new];
        [_errorButton setBackgroundColor:[UIColor colorWithRed:74/255.0 green:76/255.0 blue:91/255.0 alpha:1.0]];
        [_errorButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        _errorButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        _errorButton.layer.cornerRadius = 2;
        _errorButton.layer.masksToBounds = YES;
        [_errorButton addTarget:self
                         action:@selector(errorAction:)
               forControlEvents:UIControlEventTouchUpInside];
        _errorButton.hidden = YES;
        [self addSubview:_errorButton];
    }
    return _errorButton;
}

#pragma mark - Public Method
- (void)configErrorLog:(NSString *)errorLog
            errorImage:(NSString *)imageName
          errorHandler:(NSString *)errorHandler
{
    if (errorLog.length > 0)
    {
        self.errorLabel.text = errorLog;
    }
    if (imageName.length > 0)
    {
        self.errorImageView.image = [UIImage imageNamed:imageName];
    }
    if (errorHandler.length > 0)
    {
        self.errorButton.hidden = NO;
        [self.errorButton setTitle:errorHandler forState:UIControlStateNormal];
    }
}

#pragma mark - Action Event
- (void)errorAction:(id)sender
{
    !self.errorHandler?:self.errorHandler();
}

@end
