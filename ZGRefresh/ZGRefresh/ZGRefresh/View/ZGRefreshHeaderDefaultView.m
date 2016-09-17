//
//  ZGRefreshHeaderDefaultView.m
//  ZGRefresh
//
//  Created by 徐宗根 on 16/9/17.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshHeaderDefaultView.h"

@interface ZGRefreshHeaderDefaultView ()

@property (nonatomic, weak) UIView *labelContainView;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation ZGRefreshHeaderDefaultView


- (void)setupViews
{
    UIView *labelContainView = [[UIView alloc] init];
    self.labelContainView = labelContainView;
    [self addSubview:labelContainView];
    // titleLabel
    UILabel *titleLabel  = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"下拉可以刷新";
    [labelContainView addSubview:titleLabel];
    
    // timeLabel
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = [NSString stringWithFormat:@"最后更新时间：%@",@"00:00"];
    [labelContainView addSubview:timeLabel];
    
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
    
    self.labelContainView.frame = CGRectMake((self.bounds.size.width - labelContainViewWidth) / 2.0, (self.bounds.size.height - labelContainViewHeight) / 2.0, labelContainViewWidth, labelContainViewHeight);
    self.titleLabel.frame = CGRectMake( 0, 0, self.labelContainView.bounds.size.width, 21);
    self.timeLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.labelContainView.bounds.size.width, 21);
    self.imgView.frame = CGRectMake(self.labelContainView.frame.origin.x - 10 - imgViewHeight, (self.bounds.size.height - imgViewHeight) / 2.0, imgViewHeight, imgViewHeight);
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"state"]) {
        
        if ([change[@"new"] integerValue] == UIGestureRecognizerStateEnded) {
            //            NSLog(@"松开了手 refreshHeader");
            if (self.scrollView.contentOffset.y <= -self.bounds.size.height) {
                if (self.target && self.action) {
                    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
                    [self.target performSelector:self.action withObject:nil];
#pragma clang diagnostic pop
                    
                    // 更新时间戳
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"HH:mm";
                    NSString *timeString = [formatter stringFromDate:[[NSDate alloc] init]];
                    self.timeLabel.text = [NSString stringWithFormat:@"最后更新时间：%@",timeString];
                }
            }
        }
        return;
    }
    
    NSValue *value = change[@"new"];
    CGPoint contentOffset = [value CGPointValue];
    
    if (self.isFreshing == NO && contentOffset.y <= -self.bounds.size.height) {
        self.isFreshing = YES;
        //        NSLog(@"下拉刷新...");
        self.titleLabel.text = @"松开立即刷新";
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, M_PI);
        }];
        
    }else if(contentOffset.y >= 0 ){
        self.isFreshing = NO;
        self.titleLabel.text = @"下拉可以刷新";
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}



@end
