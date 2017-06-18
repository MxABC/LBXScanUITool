//
//  NSView+Extension.m
//  LBXScanUITool
//
//  Created by lbxia on 2017/6/12.
//  Copyright © 2017年 lbx. All rights reserved.
//

#import "NSView+Extension.h"

@implementation NSView (Extension)


- (void)setAlpha:(CGFloat)alpha
{
    [self setWantsLayer:YES];
    
    [self setAlphaValue:alpha];

}

- (void)setBackGroundColor:(NSColor*)color
{
    [self setWantsLayer:YES];
    [self.layer setBackgroundColor:color.CGColor];

}

@end
