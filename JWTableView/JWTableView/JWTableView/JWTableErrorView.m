//
//  JWTableErrorView.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableErrorView.h"

#import <Masonry.h>

@interface JWTableErrorView()

@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIImageView *errorImageView;

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
        make.centerY.equalTo(this).with.multipliedBy(0.5);
    }];
    
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.bottom.equalTo(this.mas_centerY).with.offset(-20);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - Lazy loading
- (UILabel *)errorLabel
{
    if (!_errorLabel)
    {
        self.errorLabel = [UILabel new];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.backgroundColor = self.backgroundColor;
        _errorLabel.font = [UIFont systemFontOfSize:15];
        _errorLabel.numberOfLines = 0;
        _errorLabel.textColor = [UIColor lightGrayColor];
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

#pragma mark - Public Method
- (void)configErrorLog:(NSString *)errorLog
                 image:(NSString *)imageName
{
    if (errorLog.length > 0)
    {
        self.errorLabel.text = errorLog;
    }
    if (imageName.length > 0)
    {
        self.errorImageView.image = [UIImage imageNamed:imageName];
    }
}

#pragma mark - Action Event
- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    if (self.errorHandler)
    {
        self.errorHandler();
    }
}

@end
