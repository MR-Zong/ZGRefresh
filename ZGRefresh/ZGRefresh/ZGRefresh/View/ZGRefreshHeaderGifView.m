//
//  ZGRefreshHeaderGifView.m
//  ZGRefresh
//
//  Created by 徐宗根 on 16/9/17.
//  Copyright © 2016年 Zong. All rights reserved.
//

#import "ZGRefreshHeaderGifView.h"
#import <ImageIO/ImageIO.h>

@interface ZGRefreshHeaderGifView ()

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ZGRefreshHeaderGifView

- (void)setupViews
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"haochi.gif"];
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"haochi" withExtension:@"gif"];//加载GIF图片
    //把存有UIImage的数组赋给动画图片数组
    self.imageView.animationImages = [self framesWithUrl:fileUrl];
    //设置执行一次完整动画的时长
    self.imageView.animationDuration = 6*0.15;
    //动画重复次数 （0为重复播放）
    self.imageView.animationRepeatCount = 0;
    //开始播放动画
//    [self.imageView startAnimating];
    //停止播放动画  - (void)stopAnimating;
    //判断是否正在执行动画  - (BOOL)isAnimating;
    [self addSubview:self.imageView];
}

//创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
- (NSArray *)framesWithUrl:(NSURL *)url
{
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)url, NULL);//将GIF图片转换成对应的图片源
    size_t frameCout=CGImageSourceGetCount(gifSource);//获取其中图片源个数，即由多少帧图片组成
    NSMutableArray* frames=[[NSMutableArray alloc] init];//定义数组存储拆分出来的图片
    for (size_t i=0; i<frameCout;i++){
        CGImageRef imageRef=CGImageSourceCreateImageAtIndex(gifSource, i, NULL);//从GIF图片中取出源图片
        UIImage* imageName=[UIImage imageWithCGImage:imageRef];//将图片源转换成UIimageView能使用的图片源
        [frames addObject:imageName];//将图片加入数组中
        CGImageRelease(imageRef);
    }
    return frames.copy;
}


//通过图片Data数据第一个字节 来获取图片扩展名
- (NSString *)contentTypeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            
            return nil;
            
    }
    
    return nil;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageViewWidth = 200;
    CGFloat imageViewHeight = 100;
    self.imageView.frame = CGRectMake((self.bounds.size.width - imageViewWidth) / 2.0, (self.bounds.size.height - imageViewHeight) / 2.0 , imageViewWidth,imageViewHeight);
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"state"]) {
        
        if ([change[@"new"] integerValue] == UIGestureRecognizerStateEnded) {
            //            NSLog(@"松开了手 refreshHeader");
            
            if (self.scrollView.contentOffset.y <= -self.bounds.size.height) {
                
                self.scrollView.contentInset = UIEdgeInsetsMake(self.bounds.size.height, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right);
                
                [self.imageView startAnimating];
                
                if (self.target && self.action) {
                    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
                    [self.target performSelector:self.action withObject:nil];
#pragma clang diagnostic pop
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
//        self.titleLabel.text = @"松开立即刷新";
        
        
    }else if(contentOffset.y >= 0 ){
        self.isFreshing = NO;
//        self.titleLabel.text = @"下拉可以刷新";

    }

}

- (void)startRefresh
{
    [self.imageView startAnimating];
    [super startRefresh];
}

- (void)endRefresh
{
    [super endRefresh];
    [self.imageView stopAnimating];
}

@end
