//
//  LBXScanViewStyle.m
//
//
//  Created by lbxia on 15/11/15.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanViewStyle.h"

@implementation LBXScanViewStyle

- (id)init
{
    if (self =  [super init])
    {
        _isNeedShowRetangle = YES;
        
        _whRatio = 1.0;
       
        _colorRetangleLine = [NSColor whiteColor];
        
        _centerUpOffset = 44;
        _xScanRetangleOffset = 60;
        
        _anmiationStyle = LBXScanViewAnimationStyle_LineMove;
        _photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
        
        _colorAngle = [NSColor colorWithRed:0. green:167./255. blue:231./255. alpha:1.0];
        _colorAngle = [NSColor colorWithRed:0. green:167./255. blue:231./255. alpha:1.0];
        
        _notRecoginitonArea = [NSColor colorWithRed:0. green:.0 blue:.0 alpha:.5];
        
//        _notRecoginitonArea = [NSColor redColor];
        
        
        _photoframeAngleW = 24;
        _photoframeAngleH = 24;
        _photoframeLineW = 7;
        
    }
    
    return self;
}

@end

