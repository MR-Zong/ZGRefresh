//
//  ZGRefreshHeaderView.h
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZGRefreshHeaderViewStyle)
{
    ZGRefreshHeaderViewStyleDefault,
    ZGRefreshHeaderViewStyleGif
};

@interface ZGRefreshHeaderView : UIView

+ (nullable instancetype)refreshHeaderViewWithTarget:(nullable id)target action:(nullable SEL)action style:(ZGRefreshHeaderViewStyle)style;
- (nullable instancetype)initWithTarget:(nullable id)target action:(nullable SEL)action;

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) BOOL isFreshing;
@property (weak, nonatomic) UIScrollView *scrollView;

- (void)startRefresh;
- (void)endRefresh;

@end
