//
//  ZGRefreshFooterView.h
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZGRefreshFooterView : UIView

+ (nullable instancetype)refreshFooterViewWithTarget:(nullable id)target action:(nullable SEL)action;
- (nullable instancetype)initWithTarget:(nullable id)target action:(nullable SEL)action;

@property (weak, nonatomic) UIScrollView *scrollView;

@end
