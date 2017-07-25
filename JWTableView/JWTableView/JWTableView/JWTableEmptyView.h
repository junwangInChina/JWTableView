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

- (void)configEmptyLog:(NSString *)emptyLog;

- (void)configEmptyLog:(NSString *)emptyLog
            emptyImage:(NSString *)imageName
          emptyHandler:(NSString *)emptyHandler;


@end
