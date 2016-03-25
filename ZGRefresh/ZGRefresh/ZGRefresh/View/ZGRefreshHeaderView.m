//
//  ZGRefreshHeaderView.m
//  ZGRefresh
//
//  Created by Zong on 16/3/8.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshHeaderView.h"


@interface ZGRefreshHeaderView ()

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) BOOL isFreshing;


@property (nonatomic, weak) UIView *labelContaimView;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *imgView;


@end

@implementation ZGRefreshHeaderView

+ (instancetype)refreshHeaderViewWithTarget:(id)target action:(SEL)action
{
    ZGRefreshHeaderView *refreshHeaderView = [[self alloc] initWithTarget:target action:action];
    return refreshHeaderView;
}


- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    if (self = [super init]) {
        
        self.target = target;
        self.action = action;
        [self setupViews];

    }
    return self;
}


- (void)setupViews
{
    UIView *labelContaimView = [[UIView alloc] init];
    self.labelContaimView = labelContaimView;
    [self addSubview:labelContaimView];
    // titleLabel
    UILabel *titleLabel  = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"下拉可以刷新";
    [labelContaimView addSubview:titleLabel];
    
    // timeLabel
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *timeString = [formatter stringFromDate:[[NSDate alloc] init]];
    timeLabel.text = [NSString stringWithFormat:@"最后更新时间：%@",timeString];
    [labelContaimView addSubview:timeLabel];
    
    // imgView
    UIImageView *imgView = [[UIImageView alloc] init];
    self.imgView = imgView;
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image = [UIImage imageNamed:@"refresh_down_icon"];
    imgView.transform = CGAffineTransformRotate(self.imgView.transform,M_PI);
    [self addSubview:imgView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelContainViewWidth = 150;
    CGFloat labelContainViewHeight = 42;
    CGFloat imgViewHeight = 45;
    
    self.labelContaimView.frame = CGRectMake((self.bounds.size.width - labelContainViewWidth) / 2.0, (self.bounds.size.height - labelContainViewHeight) / 2.0, labelContainViewWidth, labelContainViewHeight);
    self.titleLabel.frame = CGRectMake( 0, 0, self.labelContaimView.bounds.size.width, 21);
    self.timeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.labelContaimView.bounds.size.width, 21);
    self.imgView.frame = CGRectMake(self.labelContaimView.frame.origin.x - 10 - imgViewHeight, (self.bounds.size.height - imgViewHeight) / 2.0, imgViewHeight, imgViewHeight);
}


- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSValue *value = change[@"new"];
    CGPoint contentOffset = [value CGPointValue];
    if (self.isFreshing == NO && contentOffset.y <= -self.bounds.size.height) {
        self.isFreshing = YES;
        NSLog(@"下拉刷新...");
        self.titleLabel.text = @"松开立即刷新";
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, M_PI);
        }];
        if (self.target && self.action) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
            [self.target performSelector:self.action withObject:nil];
#pragma clang diagnostic pop
        }
        
    }else if(contentOffset.y >= 0 ){
        self.isFreshing = NO;
        self.titleLabel.text = @"下拉可以刷新";
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}



@end
