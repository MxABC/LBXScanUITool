# LBXScanUITool



LBXScanViewStyle 界面参数，通过mac app展示出来，方便大家理解

请看工具gif图

![image](https://github.com/MxABC/Resource/blob/master/LBXScanUITool.gif)

***
配合代码

```
@interface LBXScanViewStyle : NSObject


#pragma mark -中心位置矩形框
/**
 @brief  是否需要绘制扫码矩形框，默认YES
 */
@property (nonatomic, assign) BOOL isNeedShowRetangle;


/**
 *  默认扫码区域为正方形，如果扫码区域不是正方形，设置宽高比
 */
@property (nonatomic, assign) CGFloat whRatio;


/**
 @brief  矩形框(视频显示透明区)域向上移动偏移量，0表示扫码透明区域在当前视图中心位置，< 0 表示扫码区域下移, >0 表示扫码区域上移
 */
@property (nonatomic, assign) CGFloat centerUpOffset;

/**
 *  矩形框(视频显示透明区)域离界面左边及右边距离，默认60
 */
@property (nonatomic, assign) CGFloat xScanRetangleOffset;

/**
 @brief  矩形框线条颜色
 */
@property (nonatomic, strong) NSColor *colorRetangleLine;



#pragma mark -矩形框(扫码区域)周围4个角
/**
 @brief  扫码区域的4个角类型
 */
@property (nonatomic, assign) LBXScanViewPhotoframeAngleStyle photoframeAngleStyle;

//4个角的颜色
@property (nonatomic, strong) NSColor* colorAngle;

//扫码区域4个角的宽度和高度
@property (nonatomic, assign) CGFloat photoframeAngleW;
@property (nonatomic, assign) CGFloat photoframeAngleH;
/**
 @brief  扫码区域4个角的线条宽度,默认6，建议8到4之间
 */
@property (nonatomic, assign) CGFloat photoframeLineW;




#pragma mark --动画效果
/**
 @brief  扫码动画效果:线条或网格
 */
@property (nonatomic, assign) LBXScanViewAnimationStyle anmiationStyle;

/**
 *  动画效果的图像，如线条或网格的图像，如果为nil，表示不需要动画效果
 */
@property (nonatomic,strong,nullable) NSImage *animationImage;



#pragma mark -非识别区域颜色,默认 RGBA (0,0,0,0.5)

/**
 must be create by [UIColor colorWithRed: green: blue: alpha:]
 */
//notRecognitionArea
@property (nonatomic, strong) NSColor *notRecoginitonArea;


@end

```