//
//  ZGRefreshFooterDefaultView.m
//  ZGRefresh
//
//  Created by 徐宗根 on 16/9/17.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshFooterDefaultView.h"

@interface ZGRefreshFooterDefaultView ()

@property (nonatomic, weak) UIView *labelContaimView;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *imgView;
@end


@implementation ZGRefreshFooterDefaultView

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
    titleLabel.text = @"上拉可以刷新";
    [labelContaimView addSubview:titleLabel];
    
    // timeLabel
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = [NSString stringWithFormat:@"最后更新时间：%@",@"00:00"];
    [labelContaimView addSubview:timeLabel];
    
    // imgView
    UIImageView *imgView = [[UIImageView alloc] init];
    self.imgView = imgView;
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image = [UIImage imageNamed:@"refresh_up_icon"];
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


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"state"]) {
        
        if ([change[@"new"] integerValue] == UIGestureRecognizerStateEnded) {
            //            NSLog(@"松开了手 refreshFooter");
            if (self.scrollView.contentOffset.y >= (self.scrollView.contentSize.height + self.bounds.size.height - [UIScreen mainScreen].bounds.size.height)) {
                
                self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, self.bounds.size.height, self.scrollView.contentInset.right);
                
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
    
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, 100);
        return;
    }
    
    NSValue *value = change[@"new"];
    CGPoint contentOffset = [value CGPointValue];
    if (self.isFreshing == NO && contentOffset.y >= (self.scrollView.contentSize.height + self.bounds.size.height - [UIScreen mainScreen].bounds.size.height)) {
        self.isFreshing = YES;
        //        NSLog(@"上拉刷新...");
        self.titleLabel.text = @"松开立即刷新";
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, M_PI);
        }];
        
    }else if(contentOffset.y <= (self.scrollView.contentSize.height - [UIScreen mainScreen].bounds.size.height) ){
        self.isFreshing = NO;
        self.titleLabel.text = @"上拉可以刷新";
        [UIView animateWithDuration:0.25 animations:^{
            self.imgView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}


@end
