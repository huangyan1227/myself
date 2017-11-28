//
//  PlayerView.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2016/11/1.
//  Copyright © 2016年 JmoVxia. All rights reserved.
//

#import "CLPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+CLTintColor.h"
#import "UIImage+CLScaleToSize.h"
#import "UIView+CLSetRect.h"
#import "CLSlider.h"


typedef enum : NSUInteger {
    Letf = 0,
    Right,
}Direction;


//间隙
#define Padding        CLscaleX(15)
//消失时间
#define DisappearTime  6
//顶部底部控件高度
#define ViewHeight     CLscaleY(65)
//按钮大小
#define ButtonSize     CLscaleX(40)
//滑块大小
#define SliderSize     CLscaleX(30)
//进度条颜色
#define ProgressColor     [UIColor colorWithRed:1.00000f green:1.00000f blue:1.00000f alpha:0.40000f]
//缓冲颜色
#define ProgressTintColor [UIColor colorWithRed:0.14902f green:0.14902f blue:0.14902f alpha:1.00000f]
//播放完成颜色
#define PlayFinishColor   [UIColor redColor]
//滑块颜色
#define SliderColor       [UIColor whiteColor]

@interface CLPlayerView ()

/**控件原始Farme*/
@property (nonatomic,assign) CGRect customFarme;
/**父类控件*/
@property (nonatomic,strong) UIView *fatherView;
/**全屏标记*/
@property (nonatomic,assign) BOOL   isFullScreen;
/**横屏标记*/
@property (nonatomic,assign) BOOL   landscape;

/**播放器*/
@property (nonatomic,strong) AVPlayer                *player;
/**playerLayer*/
@property (nonatomic,strong) AVPlayerLayer           *playerLayer;
/**播放器item*/
@property (nonatomic,strong) AVPlayerItem            *playerItem;
/**播放进度条*/
@property (nonatomic,strong) CLSlider                *slider;
/**播放时间*/
@property (nonatomic,strong) UILabel                 *currentTimeLabel;
/**总时间*/
@property (nonatomic,strong) UILabel                 *totalTimeLabel;
/**全屏按钮*/
@property (nonatomic,strong) UIButton                *maxButton;
/**表面View*/
@property (nonatomic,strong) UIView                  *backView;
/**转子*/
@property (nonatomic,strong) UIActivityIndicatorView *activity;
/**缓冲进度条*/
@property (nonatomic,strong) UIProgressView          *progress;
/**顶部控件*/
@property (nonatomic,strong) UIView                  *topView;
/**底部控件 */
@property (nonatomic,strong) UIView                  *bottomView;
/**播放按钮*/
@property (nonatomic,strong) UIButton                *startButton;
/**轻拍定时器*/
@property (nonatomic,strong) NSTimer                 *timer;
/**slider定时器*/
@property (nonatomic,strong) NSTimer                 *sliderTimer;

/**返回按钮回调*/
@property (nonatomic,copy) void (^BackBlock) (UIButton *backButton);
/**播放完成回调*/
@property (nonatomic,copy) void (^EndBlock) (void);

@end

@implementation CLPlayerView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _customFarme         = frame;
        _isFullScreen        = NO;
        _autoFullScreen      = YES;
        _repeatPlay          = NO;
        _isLandscape         = NO;
        _landscape           = NO;
        self.backgroundColor = [UIColor blackColor];
        //开启
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        //注册屏幕旋转通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
        //APP运行状态通知，将要被挂起
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appwillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    return self;
}
#pragma mark - 是否自动支持全屏
- (void)setAutoFullScreen:(BOOL)autoFullScreen
{
    _autoFullScreen = autoFullScreen;
}
#pragma mark - 是否支持横屏
-(void)setIsLandscape:(BOOL)isLandscape
{
    _isLandscape = isLandscape;
    _landscape   = isLandscape;
}
#pragma mark - 重复播放
- (void)setRepeatPlay:(BOOL)repeatPlay
{
    _repeatPlay = repeatPlay;
}
#pragma mark - 传入播放地址
- (void)setUrl:(NSURL *)url
{
    self.frame                = _customFarme;
    _url                      = url;
    _playerItem               = [AVPlayerItem playerItemWithURL:url];
    _player                   = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer              = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame        = CGRectMake(0, 0, _customFarme.size.width, _customFarme.size.height);
    //设置静音模式播放声音
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];

    _playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.layer addSublayer:_playerLayer];
    // 监听loadedTimeRanges属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //创建原始屏幕UI
    [self originalscreen];
    
    //转子
    _activity        = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activity.center = _backView.center;
    [_activity startAnimating];
    [self addSubview:_activity];
    
    //AVPlayer播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:_player.currentItem];
}
#pragma mark - 创建播放器UI
- (void)creatUI
{
    //最上面的View
    _backView                 = [[UIView alloc]init];
    _backView.frame           = CGRectMake(0, _playerLayer.frame.origin.y, _playerLayer.frame.size.width, _playerLayer.frame.size.height);
    _backView.backgroundColor = [UIColor clearColor];
    [self addSubview:_backView];
    
    //顶部View条
    _topView                 = [[UIView alloc]init];
    _topView.frame           = CGRectMake(0, 0, _backView.CLwidth, ViewHeight);
    _topView.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.00000f];
    [_backView addSubview:_topView];
    
    //底部View条
    _bottomView                 = [[UIView alloc] init];
    _bottomView.frame           = CGRectMake(0, _backView.CLheight - ViewHeight, _backView.CLwidth, ViewHeight);
    _bottomView.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
    [_backView addSubview:_bottomView];
    
    //创建播放按钮
    [self createButton];
    //创建全屏按钮
    [self createMaxButton];
    //创建进度条
    [self createProgress];
    //创建播放条
    [self createSlider];
    //创建总时间Label
    [self createtotalTimeLabel];
    //创建播放时间Label
    [self createCurrentTimeLabel];
    //创建返回按钮
    [self createBackButton];
    
    
    
    //创建点击手势
    [self createGesture];
    //手动调用计时器时间，解决旋转等引起跳转
    [self timeStack];
    
    //计时器，循环执行
    _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timeStack)
                                   userInfo:nil
                                    repeats:YES];
    //定时器，工具条消失
    _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                              target:self
                                            selector:@selector(disappear)
                                            userInfo:nil
                                             repeats:NO];
    
}
#pragma mark - 隐藏或者显示状态栏方法
- (void)setStatusBarHidden:(BOOL)hidden
{
    //取出当前控制器的导航条
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    //设置是否隐藏
    statusBar.hidden  = hidden;
}
#pragma mark - 创建UIProgressView
- (void)createProgress
{
    CGFloat width;
    if (_isLandscape == YES)
    {
        width = self.frame.size.width;
    }
    else
    {
        if (_isFullScreen == NO)
        {
            width = self.frame.size.width;
        }
        else
        {
            width = self.frame.size.height;
        }
    }
    _progress                = [[UIProgressView alloc]init];
    _progress.frame          = CGRectMake(_startButton.CLright + Padding + 40 + Padding, 0, width - 80 - Padding - _startButton.CLright - Padding - Padding - Padding - _maxButton.CLwidth - Padding, Padding);
    _progress.CLcenterY        = _bottomView.CLheight/2.0;
    //进度条颜色
    _progress.trackTintColor = ProgressColor;
    
    // 计算缓冲进度
    NSTimeInterval timeInterval = [self availableDuration];
    CMTime duration             = _playerItem.duration;
    CGFloat totalDuration       = CMTimeGetSeconds(duration);
    CGFloat progress            = timeInterval / totalDuration;
    [_progress setProgress:progress animated:NO];
    
    CGFloat time  = round(timeInterval);
    CGFloat total = round(totalDuration);
    
    //确保都是number
    if (isnan(time) == 0 && isnan(total) == 0)
    {
        if (time == total)
        {
            //缓冲进度颜色
            _progress.progressTintColor = ProgressTintColor;
        }
        else
        {
            //缓冲进度颜色
            _progress.progressTintColor = [UIColor clearColor];
        }
    }
    else
    {
        //缓冲进度颜色
        _progress.progressTintColor = [UIColor clearColor];
    }
    [_bottomView addSubview:_progress];
}
#pragma mark - 缓存条监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        // 计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration             = _playerItem.duration;
        CGFloat totalDuration       = CMTimeGetSeconds(duration);
        CGFloat progress            = timeInterval / totalDuration;
        [_progress setProgress:progress animated:NO];
        
        //设置缓存进度颜色
        _progress.progressTintColor = ProgressTintColor;
    }
}
//计算缓冲进度
- (NSTimeInterval)availableDuration
{
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark - 创建UISlider
- (void)createSlider
{
    _slider         = [[CLSlider alloc]init];
    _slider.frame   = CGRectMake(_progress.CLx, 0, _progress.CLwidth, SliderSize);
    _slider.CLcenterY = _bottomView.CLheight/2.0;
    [_bottomView addSubview:_slider];
    
    UIImage *image     = [self getPictureWithName:@"CLRound"];
    //通过改变图片大小来改变滑块大小
    UIImage *tempImage = [image OriginImage:image scaleToSize:CGSizeMake( SliderSize, SliderSize)];
    //通过改变图片颜色来改变滑块颜色
    UIImage *newImage  = [tempImage imageWithTintColor:SliderColor];
    [_slider setThumbImage:newImage forState:UIControlStateNormal];
    
    //开始拖拽
    [_slider addTarget:self
                action:@selector(processSliderStartDragAction:)
      forControlEvents:UIControlEventTouchDown];
    //拖拽中
    [_slider addTarget:self
                action:@selector(sliderValueChangedAction:)
      forControlEvents:UIControlEventValueChanged];
    //结束拖拽
    [_slider addTarget:self
                action:@selector(processSliderEndDragAction:)
      forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    //左边颜色
    _slider.minimumTrackTintColor = PlayFinishColor;
    //右边颜色
    _slider.maximumTrackTintColor = [UIColor clearColor];
}
#pragma mark - 拖动进度条
//开始
- (void)processSliderStartDragAction:(UISlider *)slider
{
    //暂停
    [self pausePlay];
    [self destroyTimer];
}
//结束
- (void)processSliderEndDragAction:(UISlider *)slider
{
    //继续播放
    [self playVideo];
    _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                              target:self
                                            selector:@selector(disappear)
                                            userInfo:nil
                                             repeats:NO];
}
//拖拽中
- (void)sliderValueChangedAction:(UISlider *)slider
{
    //计算出拖动的当前秒数
    CGFloat total           = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    NSInteger dragedSeconds = floorf(total * slider.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime     = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime];
}

#pragma mark - 创建播放时间
- (void)createCurrentTimeLabel
{
    _currentTimeLabel           = [[UILabel alloc]init];
    _currentTimeLabel.frame     = CGRectMake(0, 0, 40, ViewHeight / 2.0);
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font      = [UIFont systemFontOfSize:12];
    _currentTimeLabel.text      = @"00:00";
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    _currentTimeLabel.CLcenterY = _progress.CLcenterY;
    _currentTimeLabel.CLleft    = _startButton.CLright + Padding;
    [_bottomView addSubview:_currentTimeLabel];
}
#pragma mark - 总时间
- (void)createtotalTimeLabel
{
    _totalTimeLabel           = [[UILabel alloc] init];
    _totalTimeLabel.frame     = CGRectMake(0, 0, 40, ViewHeight / 2.0);
    _totalTimeLabel.textColor = [UIColor whiteColor];
    _totalTimeLabel.font      = [UIFont systemFontOfSize:12];
    _totalTimeLabel.text      = @"00:00";
    _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    _totalTimeLabel.CLcenterY = _progress.CLcenterY;
    _totalTimeLabel.CLright   = _maxButton.CLleft - Padding;
    [_bottomView addSubview:_totalTimeLabel];
}

#pragma mark - 计时器事件
- (void)timeStack
{
    if (_playerItem.duration.timescale != 0)
    {
        //总共时长
        _slider.maximumValue = 1;
        //当前进度
        _slider.value        = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);
        //当前时长进度progress
        NSInteger proMin     = (NSInteger)CMTimeGetSeconds([_player currentTime]) / 60;//当前秒
        NSInteger proSec     = (NSInteger)CMTimeGetSeconds([_player currentTime]) % 60;//当前分钟
        _currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
        
        //duration 总时长
        NSInteger durMin     = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale / 60;//总分钟
        NSInteger durSec     = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale % 60;//总秒
        _totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", durMin, durSec];

        
    }
    //开始播放停止转子
    if (_player.status == AVPlayerStatusReadyToPlay)
    {
        [_activity stopAnimating];
    }
    else
    {
        [_activity startAnimating];
    }
    
}
#pragma mark - 播放按钮
- (void)createButton
{
    _startButton           = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame     = CGRectMake(Padding, 0, ButtonSize, ButtonSize);
    _startButton.CLcenterY = _bottomView.CLheight/2.0;
    [_bottomView addSubview:_startButton];
   
    //根据播放状态来设置播放按钮
    if (_player.rate == 1.0)
    {
        _startButton.selected = YES;
        [_startButton setBackgroundImage:[[self getPictureWithName:@"CLPauseBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
    else
    {
        _startButton.selected = NO;
        [_startButton setBackgroundImage:[[self getPictureWithName:@"CLPlayBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
    
    [_startButton addTarget:self
                     action:@selector(startAction:)
           forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 播放暂停按钮方法
- (void)startAction:(UIButton *)button
{
    if (button.selected == YES)
    {
        [self pausePlay];
    }
    else
    {
        [self playVideo];
    }
}
#pragma mark - 返回按钮方法
- (void)createBackButton
{
    UIButton *backButton = [UIButton new];
    backButton.frame = CGRectMake(CLscaleX(15), CLscaleX(15), CLscaleX(55), CLscaleX(55));
    backButton.layer.cornerRadius = backButton.CLwidth / 2.0;
    backButton.clipsToBounds = YES;
    backButton.backgroundColor = [UIColor colorWithRed:0.14510f green:0.17255f blue:0.21569f alpha:0.50000f];
    
    [backButton setImage:[self getPictureWithName:@"CLBackBtn"] forState:UIControlStateNormal];

    [_topView addSubview:backButton];
    
    [backButton addTarget:self
               action:@selector(backButtonAction:)
     forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 全屏按钮
- (void)createMaxButton
{
    UIButton *maxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maxButton.frame     = CGRectMake(0, 0, ButtonSize, ButtonSize);
    maxButton.CLright     = _bottomView.CLright - Padding;
    maxButton.CLcenterY   = _bottomView.CLheight / 2.0;
    [_bottomView addSubview:maxButton];
    _maxButton = maxButton;
    
    
    if (_isFullScreen == YES)
    {
        [_maxButton setBackgroundImage:[[self getPictureWithName:@"CLMinBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
    else
    {
        [_maxButton setBackgroundImage:[[self getPictureWithName:@"CLMaxBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
    
    [_maxButton addTarget:self
               action:@selector(maxAction:)
     forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 全屏按钮响应事件
- (void)maxAction:(UIButton *)button
{
    _isLandscape = NO;
    if (_isFullScreen == NO)
    {
        [self fullScreenWithDirection:Letf];
    }
    else
    {
        [self originalscreen];
    }
    _isLandscape = _landscape;
}
#pragma mark - 创建手势
- (void)createGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}
#pragma mark - 轻拍方法
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    //取消定时消失
    [self destroyTimer];
    if (_backView.alpha == 1)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _backView.alpha = 0;
        }];
    }
    else if (_backView.alpha == 0)
    {
        //添加定时消失
        _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                                  target:self
                                                selector:@selector(disappear)
                                                userInfo:nil
                                                 repeats:NO];
        
        [UIView animateWithDuration:0.5 animations:^{
            _backView.alpha = 1;
        }];
    }
}
#pragma mark - 定时消失
- (void)disappear
{
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 0;
    }];
}
#pragma mark - 播放完成
- (void)moviePlayDidEnd:(id)sender
{
    if (_repeatPlay == NO)
    {
        [self pausePlay];
    }
    else
    {
        [self resetPlay];
    }
    if (self.EndBlock)
    {
        self.EndBlock();
    }
    
}
- (void)endPlay:(EndBolck) end
{
    self.EndBlock = end;
}
#pragma mark - 返回按钮
- (void)backButtonAction:(UIButton *)button
{
    if (self.BackBlock)
    {
        self.BackBlock(button);
    }
    
    
    _isLandscape = NO;
    if (_isFullScreen == NO)
    {
        [self fullScreenWithDirection:Letf];
    }
    else
    {
        [self originalscreen];
    }
    _isLandscape = _landscape;
}
- (void)backButton:(BackButtonBlock) backButton;
{
    self.BackBlock = backButton;
    
    
}
#pragma mark - 暂停播放
- (void)pausePlay
{
    _startButton.selected = NO;
    [_player pause];
    [_startButton setBackgroundImage:[[self getPictureWithName:@"CLPlayBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
}
#pragma mark - 播放
- (void)playVideo
{
    _startButton.selected = YES;
    [_player play];
    [_startButton setBackgroundImage:[[self getPictureWithName:@"CLPauseBtn"] imageWithTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
}
#pragma mark - 重新开始播放
- (void)resetPlay
{
    [_player seekToTime:CMTimeMake(0, 1)];
    [self playVideo];
}
#pragma mark - 销毁播放器
- (void)destroyPlayer
{
    //销毁定时器
    [self destroyAllTimer];
    //暂停
    [_player pause];
    //清除
    [_player.currentItem cancelPendingSeeks];
    [_player.currentItem.asset cancelLoading];
    //移除
    [self removeFromSuperview];

}
#pragma mark - 取消定时器
//销毁所有定时器
- (void)destroyAllTimer
{
    [_sliderTimer invalidate];
    [_timer invalidate];
    _sliderTimer = nil;
    _timer       = nil;
}
//销毁定时消失定时器
- (void)destroyTimer
{
    [_timer invalidate];
    _timer = nil;
}
#pragma mark - 屏幕旋转通知
- (void)orientChange:(NSNotification *)notification
{
    if (_autoFullScreen == NO)
    {
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft)
    {
        if (_isFullScreen == NO)
        {
            [self fullScreenWithDirection:Letf];
        }
    }
    else if (orientation == UIDeviceOrientationLandscapeRight)
    {
        if (_isFullScreen == NO)
        {
            [self fullScreenWithDirection:Right];
        }
    }
    else if (orientation == UIDeviceOrientationPortrait)
    {
        if (_isFullScreen == YES)
        {
            [self originalscreen];
        }
    }
}
#pragma mark - 全屏
- (void)fullScreenWithDirection:(Direction)direction
{
    //记录播放器父类
    _fatherView = self.superview;
    
    _isFullScreen = YES;

    //取消定时器
    [self destroyAllTimer];
    
    [self setStatusBarHidden:YES];
    //添加到Window上
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    if (_isLandscape == YES)
    {
        self.frame         = CGRectMake(0, 0, CLscreenWidth, CLscreenHeight);
        _playerLayer.frame = CGRectMake(0, 0, CLscreenWidth, CLscreenHeight);
    }
    else
    {        
        if (direction == Letf)
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
            }];
        }
        else
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation( - M_PI / 2);
            }];
        }
        self.frame         = CGRectMake(0, 0, CLscreenWidth, CLscreenHeight);
        _playerLayer.frame = CGRectMake(0, 0, CLscreenHeight, CLscreenWidth);
    }
    
    //删除原有控件
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //创建全屏UI
    [self creatUI];
}
#pragma mark - 原始大小
- (void)originalscreen
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    
    _isFullScreen = NO;
    
    //取消定时器
    [self destroyAllTimer];

    [self setStatusBarHidden:NO];

    [UIView animateWithDuration:0.25 animations:^{
        //还原大小
        self.transform = CGAffineTransformMakeRotation(0);
    }];
    
    self.frame = _customFarme;
    _playerLayer.frame = CGRectMake(0, 0, _customFarme.size.width, _customFarme.size.height);
    //还原到原有父类上
    [_fatherView addSubview:self];
    
    //删除
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //创建小屏UI
    [self creatUI];
}
#pragma mark - APP活动通知
- (void)appwillResignActive:(NSNotification *)note
{
    //将要挂起，停止播放
    [self pausePlay];
}
#pragma mark - 获取资源图片
- (UIImage *)getPictureWithName:(NSString *)name
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CLPlayer" ofType:@"bundle"]];
    NSString *path   = [bundle pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}
#pragma mark - 根据Cell位置判断是否销毁
- (void)calculateWith:(UITableView *)tableView cell:(UITableViewCell *)cell topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset beyond:(BeyondBlock) beyond;
{
    //取出cell位置
    CGRect rect = cell.frame;
    //cell顶部
    CGFloat cellTop = rect.origin.y;
    //cell底部
    CGFloat cellBottom = rect.origin.y + rect.size.height;
    
    
    if (tableView.contentOffset.y + topOffset > cellBottom)
    {
        if (beyond)
        {
            beyond();
        }
        return;
    }
    
    if (cellTop > tableView.contentOffset.y + tableView.frame.size.height - bottomOffset)
    {
        if (beyond)
        {
            beyond();
        }
        return;
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    NSLog(@"播放器被销毁了");
}





@end
