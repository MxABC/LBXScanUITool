//
//  ViewController.h
//  LBXScanUITool
//
//  Created by lbxia on 2017/6/12.
//  Copyright © 2017年 lbx. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FlippedView.h"
#import "LBXScanViewStyle.h"

#import "LBXScanView.h"

@interface ViewController : NSViewController
@property (weak) IBOutlet FlippedView *iphoneView;

@property (nonatomic, strong) LBXScanViewStyle *style;
@property (nonatomic, strong) LBXScanView *scanView;

@property (weak) IBOutlet NSButton *checkBox_isNeedShowRetangle;
@property (weak) IBOutlet NSSlider *slider_wRation;
@property (weak) IBOutlet NSSlider *slider_centerUpOffset;

@property (weak) IBOutlet NSPopUpButton *popUpButton_photoframeAngleStyle;

#pragma mark ----  颜色选择按钮 -----

@property (nonatomic, weak) NSButton *preButton;

//colorRetangleLine 选择颜色按钮
@property (weak) IBOutlet NSButton *colorPanel_colorRetangleLine;

//扫码框周围4个角的线条颜色 选择按钮
@property (weak) IBOutlet NSButton *colorPanel_colorAngle;

//@property (nonatomic, strong) NSColor *preColor

@end

