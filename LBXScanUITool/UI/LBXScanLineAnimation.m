//
//  LBXScanLineAnimation.m
//
//
//  Created by lbxia on 15/11/3.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanLineAnimation.h"
#import "NSView+Extension.h"
#import <AppKit/AppKit.h>
#import <QuartzCore/QuartzCore.h>


@interface LBXScanLineAnimation()
{
    int num;
    BOOL down;
    NSTimer * timer;
    
    BOOL isAnimationing;
}

@property (nonatomic,assign) CGRect animationRect;

@end



@implementation LBXScanLineAnimation

- (BOOL)isFlipped
{
    return YES;
}


- (void)stepAnimation
{
    if (!isAnimationing) {
        return;
    }
    
    CGFloat leftx = _animationRect.origin.x - 5;
    CGFloat width = _animationRect.size.width -10 ;
    
    self.frame = CGRectMake(leftx, _animationRect.origin.y + 8, width, 8);
    self.alpha = 1.0;
    self.hidden = NO;
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.duration = 3;
    keyframeAnimation.repeatCount = NSIntegerMax;
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    CGMutablePathRef path = CGPathCreateMutable();
    

    CGPoint points[20];
    CGFloat yMin = self.frame.origin.y + 8;
    CGFloat yMax = _animationRect.origin.y + _animationRect.size.height - 8;
    
    CGFloat diff = (yMax - yMin) / 20;
    for (int i = 0; i < 20; i++) {
        points[i] = CGPointMake(leftx, yMin + diff * i);
    }
    
    
    CGPathAddLines(path, &transform, points, 20);
    
    keyframeAnimation.path = path;
    CGPathRelease(path);
    [self.layer addAnimation:keyframeAnimation forKey:@""];
    
}



- (void)startAnimatingWithRect:(CGRect)animationRect InView:(NSView *)parentView Image:(NSImage*)image
{
    if (isAnimationing) {
        return;
    }
    
    isAnimationing = YES;

    
    self.animationRect = animationRect;
    down = YES;
    num = 0;
    
    CGFloat centery = CGRectGetMinY(animationRect) + CGRectGetHeight(animationRect)/2;
    CGFloat leftx = animationRect.origin.x + 5;
    CGFloat width = animationRect.size.width - 10;
    
    self.frame = CGRectMake(leftx, centery+2*num, width, 2);
    self.image = image;
    
    [parentView addSubview:self];
    
    [self startAnimating_UIViewAnimation];
    
//    [self startAnimating_NSTimer];
    
    
}

- (void)startAnimating_UIViewAnimation
{
     [self stepAnimation];
}

- (void)startAnimating_NSTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanLineAnimation) userInfo:nil repeats:YES];
}

-(void)scanLineAnimation
{
    CGFloat centery = CGRectGetMinY(_animationRect) + CGRectGetHeight(_animationRect)/2;
    CGFloat leftx = _animationRect.origin.x + 5;
    CGFloat width = _animationRect.size.width - 10;
    
    if (down)
    {
        num++;
        
        self.frame = CGRectMake(leftx, centery+2*num, width, 2);
        
        if (centery+2*num > (CGRectGetMinY(_animationRect) + CGRectGetHeight(_animationRect) - 5 ) )
        {
            down = NO;
        }
    }
    else {
        num --;
        self.frame = CGRectMake(leftx, centery+2*num, width, 2);
        if (centery+2*num < (CGRectGetMinY(_animationRect) + 5 ) )
        {
            down = YES;
        }
    }
}

- (void)dealloc
{
    [self stopAnimating];
}

- (void)stopAnimating
{
    if (isAnimationing) {
        
        isAnimationing = NO;
        
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        
        [self removeFromSuperview];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];  
}

@end
