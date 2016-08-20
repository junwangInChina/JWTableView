//
//  JWTableEmptyView.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableEmptyView.h"

#import <Masonry/Masonry.h>

@interface JWTableEmptyView()

@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) UIImageView *emptyImageView;

@end

@implementation JWTableEmptyView

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
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.centerY.equalTo(this).with.multipliedBy(0.5);
    }];
    
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.bottom.equalTo(this.mas_centerY).with.offset(-20);
    }];
    
    
}

#pragma mark - Lazy loading
- (UILabel *)emptyLabel
{
    if (!_emptyLabel)
    {
        self.emptyLabel = [UILabel new];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.backgroundColor = self.backgroundColor;
        _emptyLabel.font = [UIFont systemFontOfSize:15];
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.textColor = [UIColor lightGrayColor];
        _emptyLabel.text = @"暂无数据";
        [self addSubview:_emptyLabel];
    }
    return _emptyLabel;
}

- (UIImageView *)emptyImageView
{
    if (!_emptyImageView)
    {
        self.emptyImageView = [UIImageView new];
        _emptyImageView.backgroundColor = self.backgroundColor;
        [self addSubview:_emptyImageView];
    }
    return _emptyImageView;
}

#pragma mark - Public Method
- (void)configEmptyLog:(NSString *)emptyLog
                 image:(NSString *)imageName
{
    if (emptyLog.length > 0)
    {
        self.emptyLabel.text = emptyLog;
    }
    if (imageName.length > 0)
    {
        self.emptyImageView.image = [UIImage imageNamed:imageName];
    }
}

@end
