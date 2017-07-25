//
//  JWTableEmptyView.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableEmptyView.h"

#import "JWTableViewDefine.h"

#import <Masonry/Masonry.h>

@interface JWTableEmptyView()

@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) UIImageView *emptyImageView;
@property (nonatomic, strong) UIButton *emptyButton;

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
        make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(415.0/3));
    }];
    
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(705.0/3));
    }];
    
    [self.emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(860.0/3));
        make.size.mas_equalTo(CGSizeMake(800.0/3, 50));
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
        _emptyLabel.font = [UIFont fontWithName:@"Arial" size:14];
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.textColor = [UIColor colorWithRed:74/255.0 green:76/255.0 blue:91/255.0 alpha:1.0];
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

- (UIButton *)emptyButton
{
    if (!_emptyButton)
    {
        self.emptyButton = [UIButton new];
        [_emptyButton setBackgroundColor:[UIColor colorWithRed:74/255.0 green:76/255.0 blue:91/255.0 alpha:1.0]];
        [_emptyButton setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        _emptyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        _emptyButton.layer.cornerRadius = 2;
        _emptyButton.layer.masksToBounds = YES;
        [_emptyButton addTarget:self
                         action:@selector(emptyAction:)
               forControlEvents:UIControlEventTouchUpInside];
        _emptyButton.hidden = YES;
        [self addSubview:_emptyButton];
    }
    return _emptyButton;
}

#pragma mark - Public Method
- (void)configEmptyLog:(NSString *)emptyLog
{
    if (emptyLog.length > 0)
    {
        self.emptyLabel.text = emptyLog;
        
        __weak __typeof(self)this = self;        
        [self.emptyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(this);
            make.top.equalTo(this).with.offset(JW_HEIGHT_TRANSF(30));
        }];
    }
}

- (void)configEmptyLog:(NSString *)emptyLog
            emptyImage:(NSString *)imageName
          emptyHandler:(NSString *)emptyHandler
{
    if (emptyLog.length > 0)
    {
        self.emptyLabel.text = emptyLog;
    }
    if (imageName.length > 0)
    {
        self.emptyImageView.image = [UIImage imageNamed:imageName];
    }
    if (emptyHandler.length > 0)
    {
        self.emptyButton.hidden = NO;
        [self.emptyButton setTitle:emptyHandler forState:UIControlStateNormal];
    }
}

#pragma mark - Helper
- (void)emptyAction:(id)sender
{
    !self.emptyHandler?:self.emptyHandler();
}
@end
