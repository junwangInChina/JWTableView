//
//  JWTableViewCell.m
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import "JWTableViewCell.h"

#import <Masonry/Masonry.h>

@interface JWTableViewCell()

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) JWSeparatorInsert commonSeparatorInsert;
@property (nonatomic, assign) JWSeparatorInsert lastSeparatorInsert;
@property (nonatomic, assign) BOOL isLastCell;

@end

@implementation JWTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.separatorView.hidden = YES;
        self.commonSeparatorInsert = JWSeparatorInsertMake(10,0);
        self.lastSeparatorInsert = JWSeparatorInsertMake(0,0);
        self.isLastCell = NO;
    }
    return self;
}

- (UIView *)separatorView
{
    if (!_separatorView)
    {
        self.separatorView = [UIView new];
        _separatorView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [self addSubview:_separatorView];
    }
    return _separatorView;
}

#pragma mark - Public Method
- (void)configCustomSeparator:(BOOL)useCustomSeparator color:(UIColor *)separatorColor
{
    self.separatorView.hidden = !useCustomSeparator;
    if (separatorColor)
    {
        self.separatorView.backgroundColor = separatorColor;
    }
}

- (void)configCommonSeparatorInsert:(JWSeparatorInsert)commonInsert
                lastSeparatorInsert:(JWSeparatorInsert)lastInsert
{
    self.commonSeparatorInsert = commonInsert;
    self.lastSeparatorInsert = lastInsert;
}

- (void)isLastCell:(BOOL)isLast
{
    self.isLastCell = isLast;
    
    [self setNeedsUpdateConstraints];
    
    [self updateConstraintsIfNeeded];
    
    [self layoutIfNeeded];
}

#pragma mark - UIView updateConstraints
- (void)updateConstraints
{
    __weak __typeof(self)this = self;
    [self.separatorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.equalTo(this);
        
        if (this.isLastCell)
        {
            make.left.equalTo(this).with.offset(this.lastSeparatorInsert.forwardInsert);
            make.right.equalTo(this).with.offset(-this.lastSeparatorInsert.backwardInsert);
            make.width.equalTo(this).with.offset(-(this.lastSeparatorInsert.forwardInsert + this.lastSeparatorInsert.backwardInsert));
        }
        else
        {
            make.left.equalTo(this).with.offset(this.commonSeparatorInsert.forwardInsert);
            make.right.equalTo(this).with.offset(-this.commonSeparatorInsert.backwardInsert);
            make.width.equalTo(this).with.offset(-(this.commonSeparatorInsert.forwardInsert + this.commonSeparatorInsert.backwardInsert));
        }
    }];
    
    [super updateConstraints];
}

@end
