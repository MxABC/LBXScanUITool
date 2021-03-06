//
//  LBXScanView.h
//
//  github:https://github.com/MxABC/LBXScan
//  Created by lbxia on 15/11/15.
//  Copyright © 2015年 lbxia. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "LBXScanLineAnimation.h"
#import "LBXScanNetAnimation.h"
#import "LBXScanViewStyle.h"

#define LBXScan_Define_UI

/**
 扫码区域显示效果
 */
@interface LBXScanView : NSView
//扫码区域各种参数
@property (nonatomic, strong) LBXScanViewStyle* viewStyle;
/**
 @brief  初始化
 @param frame 位置大小
 @param style 类型

 @return instancetype
 */
-(id)initWithFrame:(CGRect)frame style:(LBXScanViewStyle*)style;

/**
 *  设备启动中文字提示
 */
- (void)startDeviceReadyingWithText:(NSString*)text;

/**
 *  设备启动完成
 */
- (void)stopDeviceReadying;

/**
 *  开始扫描动画
 */
- (void)startScanAnimation;

/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;



@end
