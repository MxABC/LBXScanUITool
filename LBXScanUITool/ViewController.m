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
    
    //非识别区颜色
    [_colorPanel_notRecoginitonArea setBackGroundColor:_style.notRecoginitonArea];
    _colorPanel_notRecoginitonArea.transparent = YES;
    _colorPanel_notRecoginitonArea.bordered = NO;
    
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
    
    [self loadParamenter2LabelShow];
}

- (void)loadParamenter2LabelShow
{
    //默认参数值显示
    _label_whRatio.stringValue = [NSString stringWithFormat:@"%.1f",_style.whRatio];
    _label_centerUpOffset.stringValue = [NSString stringWithFormat:@"%d",(int)_style.centerUpOffset];
    _label_xScanRetangleOffset.stringValue = [NSString stringWithFormat:@"%d",(int)_style.xScanRetangleOffset];
    _label_colorRetangleLine.stringValue = [self stringFromColor:_style.colorRetangleLine];
    _label_colorAngle.stringValue = [self stringFromColor:_style.colorAngle];
    _label_photoframeAngleW.stringValue = [NSString stringWithFormat:@"%d",(int)_style.photoframeAngleW];
    _label_photoframeAngleH.stringValue = [NSString stringWithFormat:@"%d",(int)_style.photoframeAngleH];
    _label_photoframeLineW.stringValue = [NSString stringWithFormat:@"%d",(int)_style.photoframeLineW];
    _label_notRecoginitonArea.stringValue = [self stringFromColor:_style.notRecoginitonArea];
    _label_notRecoginitonArea_alpha.stringValue = [self stringAlphaFromColor:_style.notRecoginitonArea];
}

- (NSString*)stringFromColor:(NSColor*)color
{
    const CGFloat *components = CGColorGetComponents( color.CGColor);
    
    
    CGFloat red_notRecoginitonArea = components[0];
    CGFloat green_notRecoginitonArea = components[1];
    CGFloat blue_notRecoginitonArea = components[2];

    
    return [NSString stringWithFormat:@"RGB(%d,%d,%d)",(int)(red_notRecoginitonArea*255),(int)(green_notRecoginitonArea*255),(int)(blue_notRecoginitonArea*255)];
    
}

- (NSString*)stringAlphaFromColor:(NSColor*)color
{
    const CGFloat *components = CGColorGetComponents( color.CGColor);
    CGFloat alpha_notRecoginitonArea = components[3];
    return [NSString stringWithFormat:@"%.1f",alpha_notRecoginitonArea];
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
    else if (_preButton == _colorPanel_notRecoginitonArea)
    {
        colorpanel.color = _style.notRecoginitonArea;
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
       
    }
    else if (_preButton == _colorPanel_colorAngle)
    {
     
        [_colorPanel_colorAngle setBackGroundColor:panelColor];
        
        //扫码框4个角颜色
        _style.colorAngle = panelColor;
   
    }
    else if (_preButton == _colorPanel_notRecoginitonArea)
    {
        [_colorPanel_notRecoginitonArea setBackGroundColor:panelColor];
        const CGFloat *components = CGColorGetComponents(panelColor.CGColor);
        
        
        CGFloat red_notRecoginitonArea = components[0];
        CGFloat green_notRecoginitonArea = components[1];
        CGFloat blue_notRecoginitonArea = components[2];
//        CGFloat alpa_notRecoginitonArea = components[3];

        NSColor *color = [NSColor colorWithRed:red_notRecoginitonArea green:green_notRecoginitonArea blue:blue_notRecoginitonArea alpha:0.5];
        
        _style.notRecoginitonArea = color;
    }
    
    [self loadParamenter2LabelShow];
    
    [_scanView setNeedsDisplay:YES];

}


- (IBAction)sliderAction:(id)sender {
    
    
    _label_whRatio.stringValue = [NSString stringWithFormat:@"%.1f",_style.whRatio];
    _label_centerUpOffset.stringValue = [NSString stringWithFormat:@"%d",(int)_style.centerUpOffset];
    _label_xScanRetangleOffset.stringValue = [NSString stringWithFormat:@"%d",(int)_style.xScanRetangleOffset];
    _label_colorRetangleLine.stringValue = [self stringFromColor:_style.colorRetangleLine];
    _label_colorAngle.stringValue = [self stringFromColor:_style.colorAngle];
    _label_photoframeAngleW.stringValue = [NSString stringWithFormat:@"%d",(int)_style.photoframeAngleW];
    _label_photoframeAngleH.stringValue = [NSString stringWithFormat:@"%d",(int)_style.photoframeAngleH];
    _label_photoframeLineW.stringValue = [NSString stringWithFormat:@"%d",(int)_style.photoframeLineW];
    _label_notRecoginitonArea.stringValue = [self stringFromColor:_style.notRecoginitonArea];
    _label_notRecoginitonArea_alpha.stringValue = [self stringAlphaFromColor:_style.notRecoginitonArea];
    
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
    else if (sender == _slider_xScanRetangleOffset)
    {
        _style.xScanRetangleOffset = _slider_xScanRetangleOffset.integerValue;
    }
    else if (sender == _slider_photoframeAngleW)
    {
        _style.photoframeAngleW = _slider_photoframeAngleW.integerValue;
    }
    else if (sender == _slider_photoframeAngleH)
    {
        _style.photoframeAngleH = _slider_photoframeAngleH.integerValue;
    }
    else if (sender == _slider_photoframeAngleH)
    {
        _style.photoframeAngleH = _slider_photoframeAngleH.integerValue;
    }
    else if (sender == _slider_photoframeLineW)
    {
        _style.photoframeLineW = _slider_photoframeLineW.integerValue;
    }
    else if (sender == _slider_notRecoginitonArea_Alpa)
    {
        const CGFloat *components = CGColorGetComponents( _style.notRecoginitonArea.CGColor);
        
        
        CGFloat red_notRecoginitonArea = components[0];
        CGFloat green_notRecoginitonArea = components[1];
        CGFloat blue_notRecoginitonArea = components[2];
        //        CGFloat alpa_notRecoginitonArea = components[3];
        
        CGFloat alpha = _slider_notRecoginitonArea_Alpa.integerValue / 100.0;
        
        NSColor *color = [NSColor colorWithRed:red_notRecoginitonArea green:green_notRecoginitonArea blue:blue_notRecoginitonArea alpha:alpha];
        
        _style.notRecoginitonArea = color;
        
        [_scanView setNeedsDisplay:YES];

    }
    
    [self loadParamenter2LabelShow];
    
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
    
//    [_scanView startScanAnimation];
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
    
    style.colorRetangleLine = [NSColor colorWithRed:0 green:0 blue:1 alpha:1.];
    
    //线条上下移动图片
    style.animationImage = [NSImage imageNamed:@"qrcode_scan_light_green"];
    
    return style;
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
