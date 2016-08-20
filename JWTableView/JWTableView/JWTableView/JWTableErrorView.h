//
//  JWTableErrorView.h
//  JWTableView
//
//  Created by wangjun on 16/8/19.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTableErrorView : UIView

@property (nonatomic, copy) void(^errorHandler)();

- (void)configErrorLog:(NSString *)errorLog
                 image:(NSString *)imageName;

@end
