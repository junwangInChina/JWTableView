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
        make.centerY.equalTo(this).with.multipliedBy(0.5);
    }];
    
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(this);
        make.top.equalTo(this.emptyImageView.mas_bottom).with.offset(88/3);
    }];
    
    [self.emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(this).with.insets(UIEdgeInsetsMake(0, 36, 29, 36));
        make.height.equalTo(@0);
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

- (UIButton *)emptyButton
{
    if (!_emptyButton)
    {
        self.emptyButton = [UIButton new];
        [_emptyButton setBackgroundColor:[UIColor colorWithRed:5.0/255.0 green:163.0/255.0 blue:236.0/255.0 alpha:1]];
        [_emptyButton setTitle:@""
                    forState:UIControlStateNormal];
        [_emptyButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        [_emptyButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]
                         forState:UIControlStateHighlighted];
        _emptyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _emptyButton.layer.cornerRadius = 5;
        _emptyButton.layer.masksToBounds = YES;
        [_emptyButton addTarget:self
                       action:@selector(emptyButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
        _emptyButton.hidden = YES;
        [self addSubview:_emptyButton];
    }
    return _emptyButton;
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

- (void)configEmptyLog:(NSString *)emptyLog
                 image:(NSString *)imageName
          handlerTitle:(NSString *)handlerTitle
          centerInView:(BOOL)centerInView
{
    if (emptyLog.length > 0)
    {
        self.emptyLabel.text = emptyLog;
    }
    if (imageName.length > 0)
    {
        self.emptyImageView.image = [UIImage imageNamed:imageName];
    }
    if (handlerTitle.length > 0)
    {
        self.emptyButton.hidden = NO;
        [self.emptyButton setTitle:handlerTitle
                          forState:UIControlStateNormal];
        
        self.emptyLabel.textColor = [UIColor colorWithRed:44.0/255.0 green:101.0/255.0 blue:146.0/255.0 alpha:1];
        
        __weak __typeof(self)this = self;
        [self.emptyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(this);
        }];
        
        [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(this);
            make.bottom.equalTo(this.emptyLabel.mas_top).with.offset(-15);
        }];
        
        [self.emptyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(this);
            make.top.equalTo(this.emptyLabel.mas_bottom).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(200, 44));
        }];
    }
    else
    {
        __weak __typeof(self)this = self;
        if (centerInView)
        {
            [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(this);
                make.bottom.equalTo(this.mas_centerY).with.offset(10);
            }];
            
            [self.emptyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(this);
                make.top.equalTo(this.emptyImageView.mas_bottom).with.offset(10);
            }];
        }
        else
        {
            [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(this);
                make.bottom.equalTo(this.emptyLabel.mas_top).with.offset(-0);
            }];
            
            [self.emptyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(this);
                make.centerY.equalTo(this).with.multipliedBy((720/1611.0)+1);
            }];
        }
    }
}

- (void)configHandlerHidden:(BOOL)hidden
{
    self.emptyButton.hidden = hidden;
}

#pragma mark - Helper
- (void)emptyButtonAction:(id)sender
{
    if (self.emptyHandler)
    {
        self.emptyHandler();
    }
}
@end
