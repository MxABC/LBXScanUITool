//
//  ViewController.m
//  LBXScanUITool
//
//  Created by lbxia on 2017/6/12.
//  Copyright © 2017年 lbx. All rights reserved.
//

#import "ViewController.h"

#import "NSView+Extension.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    self.title = @"LBXScan";
    self.style = [self defaultStyle];
    
    [self performSelector:@selector(drawScanView) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(delayInitUI) withObject:nil afterDelay:0.3];
  
}

- (void)delayInitUI
{
    //扫码框颜色 设置按钮
    [_colorPanel_colorRetangleLine setBackGroundColor:_style.colorRetangleLine];
    _colorPanel_colorRetangleLine.transparent = YES;
    _colorPanel_colorRetangleLine.bordered = NO;
    
    //扫码框 4个角 设置按钮
    [_colorPanel_colorAngle setBackGroundColor:_style.colorAngle];
    _colorPanel_colorAngle.transparent = YES;
    _colorPanel_colorAngle.bordered = NO;
    
    //相框角 选择list
    [_popUpButton_photoframeAngleStyle removeAllItems];
    [_popUpButton_photoframeAngleStyle addItemWithTitle:@"Inner"];
    [_popUpButton_photoframeAngleStyle addItemWithTitle:@"Outer"];
    [_popUpButton_photoframeAngleStyle addItemWithTitle:@"On"];
    [_popUpButton_photoframeAngleStyle addItemWithTitle:@"None"];
    switch (_style.photoframeAngleStyle) {
        case LBXScanViewPhotoframeAngleStyle_Inner:
            [_popUpButton_photoframeAngleStyle selectItemAtIndex:0];
            break;
        case LBXScanViewPhotoframeAngleStyle_Outer:
            [_popUpButton_photoframeAngleStyle selectItemAtIndex:1];
            break;
        case LBXScanViewPhotoframeAngleStyle_On:
            [_popUpButton_photoframeAngleStyle selectItemAtIndex:2];
            break;
        case LBXScanViewPhotoframeAngleStyle_None:
            [_popUpButton_photoframeAngleStyle selectItemAtIndex:3];
            break;
            
        default:
            break;
    }
    
    
    
}


//是否显示扫码框
- (IBAction)checkBoxAction_isNeedShowRetangle:(id)sender {
    
    NSLog(@"%ld",_checkBox_isNeedShowRetangle.state);
    
    _style.isNeedShowRetangle = _checkBox_isNeedShowRetangle.state;
    
    [_scanView setNeedsDisplay:YES];
}


//打开颜色面板
- (IBAction)openColorPanel:(id)sender
{
    self.preButton = sender;
    
    NSColorPanel *colorpanel = [NSColorPanel sharedColorPanel];
    colorpanel.mode = NSColorPanelModeRGB;
    [colorpanel setAction:@selector(changeColor:)];
    [colorpanel setTarget:self];
    
    //初始化面板颜色
    if (_preButton == _colorPanel_colorRetangleLine) {
        colorpanel.color = _style.colorRetangleLine;
    }
    else if (_preButton == _colorPanel_colorAngle){
        colorpanel.color = _style.colorAngle;
    }
    
    
    [colorpanel orderFront:_checkBox_isNeedShowRetangle];

}

- (void)changeColor:(id)sender {
    NSColorPanel *colorPanel = sender ;
    NSColor* panelColor = colorPanel.color;
    
    NSLog(@"%@",panelColor);
    
    if (_preButton == _colorPanel_colorRetangleLine) {
        
        [_colorPanel_colorRetangleLine setBackGroundColor:panelColor];
        
        //扫码框颜色
        _style.colorRetangleLine = panelColor;
        [_scanView setNeedsDisplay:YES];
    }
    else if (_preButton == _colorPanel_colorAngle)
    {
     
        [_colorPanel_colorAngle setBackGroundColor:panelColor];
        
        //扫码框4个角颜色
        _style.colorAngle = panelColor;
        [_scanView setNeedsDisplay:YES];
    }


}



- (IBAction)sliderAction:(id)sender {
    
    if (sender == _slider_wRation) {
        NSLog(@"%f",  _slider_wRation.doubleValue);
        //0---200 范围 类比到 0.0 --- 2.0
        double wRation = _slider_wRation.doubleValue / 100.0;
        _style.whRatio = wRation;
    }
    else if (sender == _slider_centerUpOffset)
    {
        NSLog(@"%ld",  _slider_centerUpOffset.integerValue);
        _style.centerUpOffset = _slider_centerUpOffset.integerValue;
    }
    
    [_scanView setNeedsDisplay:YES];

}
- (IBAction)popUpButtonAction:(id)sender {
    
    if (sender == _popUpButton_photoframeAngleStyle) {
        
        switch (_popUpButton_photoframeAngleStyle.indexOfSelectedItem) {
            case 0:
                _style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
                break;
            case 1:
                _style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
                break;
            case 2:
                _style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
                break;
            case 3:
                _style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_None;
                break;
            default:
                break;
        }
        [_scanView setNeedsDisplay:YES];
    }
}


#pragma mark ----  绘制扫码区域  -----

- (void)drawScanView
{
    CGRect frame = _iphoneView.frame;
    frame.origin = CGPointMake(0, 0);
    
    
    //添加标题 "扫一扫"
    CGRect frame1 = frame;
    frame1.origin.y += 14;
    frame1.size.height -= 14;
    NSTextField *titleLabel = [[NSTextField alloc]initWithFrame:frame1];
    titleLabel.stringValue = @"扫一扫";
    titleLabel.textColor = [NSColor whiteColor];
    titleLabel.font = [NSFont systemFontOfSize:16];
    titleLabel.alignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor =  [NSColor colorWithRed:53/255. green:143/255. blue:231/255. alpha:1.];
    // 不设置会导致背景颜色去不掉
    titleLabel.bordered = NO;
    
    [titleLabel setEditable:NO];
    // 设置为禁用， 就不能点击到text ，就不会出现蓝色的边框，设置静态文本时一定要设置这个属性
    [titleLabel setEnabled:NO];
    
    [_iphoneView addSubview:titleLabel];
    
    
    //模拟相机界面
    frame.origin.y += 44;
    frame.size.height -= 44;
    NSImageView *imgView = [[NSImageView alloc]initWithFrame:frame];
    imgView.image= [NSImage imageNamed:@"backImg"];
    imgView.imageScaling = NSImageScaleAxesIndependently;
    [_iphoneView addSubview:imgView];
    
    //添加扫码效果
    frame = _iphoneView.frame;
    frame.origin = CGPointMake(0, 44);
    frame.size.height -= 44;
    LBXScanView * scanview = [[LBXScanView alloc]initWithFrame:frame style:_style];
    [_iphoneView addSubview:scanview];
    
    [_iphoneView setBackGroundColor:[NSColor colorWithRed:53/255. green:143/255. blue:231/255. alpha:1.]];
    
    self.scanView = scanview;
}

#pragma mark -模仿qq界面
- (LBXScanViewStyle*)defaultStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    style.colorRetangleLine = [NSColor blueColor];
    
    //线条上下移动图片
    style.animationImage = [NSImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    return style;
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
