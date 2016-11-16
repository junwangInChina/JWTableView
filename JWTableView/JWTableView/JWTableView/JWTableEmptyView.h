//
//  JWTableEmptyView.h
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTableEmptyView : UIView

@property (nonatomic, copy) void(^emptyHandler)();

- (void)configEmptyLog:(NSString *)emptyLog
                 image:(NSString *)imageName;

- (void)configEmptyLog:(NSString *)emptyLog
                 image:(NSString *)imageName
          handlerTitle:(NSString *)handlerTitle
          centerInView:(BOOL)centerInView;

- (void)configHandlerHidden:(BOOL)hidden;

@end
