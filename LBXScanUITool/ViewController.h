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
@property (weak) IBOutlet NSSlider *slider_xScanRetangleOffset;

@property (weak) IBOutlet NSSlider *slider_photoframeAngleW;
@property (weak) IBOutlet NSSlider *slider_photoframeAngleH;
@property (weak) IBOutlet NSSlider *slider_photoframeLineW;

@property (weak) IBOutlet NSSlider *slider_notRecoginitonArea_Alpa;

@property (weak) IBOutlet NSPopUpButton *popUpButton_photoframeAngleStyle;

#pragma mark ----  颜色选择按钮 -----

@property (nonatomic, weak) NSButton *preButton;

//colorRetangleLine 选择颜色按钮
@property (weak) IBOutlet NSButton *colorPanel_colorRetangleLine;

//扫码框周围4个角的线条颜色 选择按钮
@property (weak) IBOutlet NSButton *colorPanel_colorAngle;
@property (weak) IBOutlet NSButton *colorPanel_notRecoginitonArea;

#pragma mark ----  结果显示label ----

@property (weak) IBOutlet NSTextField *label_whRatio;
@property (weak) IBOutlet NSTextField *label_centerUpOffset;
@property (weak) IBOutlet NSTextField *label_xScanRetangleOffset;
@property (weak) IBOutlet NSTextField *label_colorRetangleLine;
@property (weak) IBOutlet NSTextField *label_colorAngle;
@property (weak) IBOutlet NSTextField *label_photoframeAngleW;
@property (weak) IBOutlet NSTextField *label_photoframeAngleH;
@property (weak) IBOutlet NSTextField *label_photoframeLineW;
@property (weak) IBOutlet NSTextField *label_notRecoginitonArea;
@property (weak) IBOutlet NSTextField *label_notRecoginitonArea_alpha;



@end

