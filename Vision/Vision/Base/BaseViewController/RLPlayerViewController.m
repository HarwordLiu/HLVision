//
//  RLPlayerViewController.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/4.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "RLPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "RLPlayerView.h"

@interface RLPlayerViewController ()
@property (nonatomic, assign) BOOL played;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, copy) NSString *totalTime;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) RLPlayerView *playerView;

@property (nonatomic, strong) UIView *titleBackView;
@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeProgressLabel;
@property (nonatomic, strong) UILabel *timeEndedLabel;

@property (nonatomic, strong) UISlider *videoSlider;
@property (nonatomic, strong) UIProgressView *videoProgress;

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) id playbackTimeObserver;
@end

@implementation RLPlayerViewController

// 设置横屏显示
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    // 取消当前播放Item
    [self.playerView.player replaceCurrentItemWithPlayerItem:nil];
    self.videoSlider.maximumValue = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];

    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFrame];
    [self setPlayerItemURL];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.playerView.player pause];
}

// 初始化页面控件
- (void)initFrame {
    self.view.backgroundColor = [UIColor blackColor];
    self.view.frame = CGRectMake(0, 0, SCREENFRAMEHEIGHT, SCREENFRAMEWEIGHT);
    self.playerView = [[RLPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEHEIGHT, SCREENFRAMEWEIGHT)];
    [self.view addSubview:self.playerView];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(0, 0, 100, 100);
    self.playBtn.center = self.view.center;
    self.playBtn.backgroundColor = [UIColor clearColor];
    // 防止未准备播放点击播放
    self.playBtn.enabled = NO;
    [self.playBtn setImage:[UIImage imageNamed:@"btn_play@3x"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"btn_pause@3x"] forState:UIControlStateSelected];
    [self.view addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(clickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEHEIGHT, SCREENFRAMEWEIGHT / 6)];
    self.titleBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    [self.view addSubview:self.titleBackView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, SCREENFRAMEWEIGHT / 6, SCREENFRAMEWEIGHT / 6);
    [self.backBtn setImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    self.backBtn.backgroundColor = [UIColor clearColor];
    [self.backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleBackView addSubview:self.backBtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENFRAMEWEIGHT / 6, 0, SCREENFRAMEWEIGHT, SCREENFRAMEWEIGHT / 6)];
    self.titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:16];
    self.titleLabel.text = self.model.title;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.titleBackView addSubview:self.titleLabel];
    
    self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENFRAMEWEIGHT - SCREENFRAMEWEIGHT / 6, SCREENFRAMEHEIGHT, SCREENFRAMEWEIGHT)];
    self.progressView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    [self.view addSubview:self.progressView];
    
    self.videoProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.videoProgress.frame = CGRectMake(SCREENFRAMEHEIGHT * 0.15 + 2, SCREENFRAMEWEIGHT / 12, SCREENFRAMEHEIGHT * 0.7 - 4, SCREENFRAMEWEIGHT / 6);
    self.videoProgress.backgroundColor = [UIColor clearColor];
    [self.progressView addSubview:self.videoProgress];
    
    self.videoSlider = [[UISlider alloc] initWithFrame:CGRectMake(SCREENFRAMEHEIGHT * 0.15, 0, SCREENFRAMEHEIGHT * 0.7, SCREENFRAMEWEIGHT / 6)];
    self.videoSlider.backgroundColor = [UIColor clearColor];
    self.videoSlider.minimumTrackTintColor = [UIColor clearColor];
    self.videoSlider.maximumTrackTintColor = [UIColor clearColor];
    self.videoSlider.minimumValue = 0;
    self.videoSlider.enabled = NO;
    [self.progressView addSubview:self.videoSlider];
    
    [self.videoSlider addTarget:self action:@selector(videoSliderTouchChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.videoSlider addTarget:self action:@selector(videoSliderTouchChangeValueEnd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.timeProgressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAMEHEIGHT * 0.15, SCREENFRAMEWEIGHT / 6)];
    self.timeProgressLabel.textAlignment = NSTextAlignmentCenter;
    self.timeProgressLabel.textColor = [UIColor whiteColor];
    self.timeProgressLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:16];
    self.timeProgressLabel.text = @" 00:00 ";
    [self.progressView addSubview:self.timeProgressLabel];
    
    self.timeEndedLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENFRAMEHEIGHT * 0.85, 0, SCREENFRAMEHEIGHT * 0.15, SCREENFRAMEWEIGHT / 6)];
    self.timeEndedLabel.textAlignment = NSTextAlignmentCenter;
    self.timeEndedLabel.textColor = [UIColor whiteColor];
    self.timeEndedLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:16];
    self.timeEndedLabel.text = @" 00:00 ";
    [self.progressView addSubview:self.timeEndedLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewController:)];
    [self.view addGestureRecognizer:tap];
    
    
    
}

- (void)setPlayerItemURL {
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.model.playUrl]];
    NSLog(@"%@", self.model.playUrl);
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil]; // 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil]; // 监听loadedTimeRanges
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    
}

// KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *playItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            self.playBtn.enabled = YES;
            self.videoSlider.enabled = YES;
            
            CMTime duration = self.playerItem.duration; // 获取视频总长度
            CGFloat totalSecond = playItem.duration.value / playItem.duration.timescale; // 转换成秒
            self.totalTime = [self convertTime:totalSecond]; // 转换成播放时间
            self.timeEndedLabel.text = self.totalTime;
            [self customVideoSlider:duration]; // 自定义UISlider外观
            NSLog(@"movie total duration:%f", CMTimeGetSeconds(duration));
            [self monitoringPlayback:self.playerItem]; // 监听播放状态
        } else if ([playItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

- (void)videoSliderTouchChangeValue:(UISlider *)slider {
    self.playBtn.alpha = 1;
    self.progressView.alpha = 1;
    self.titleBackView.alpha = 1;
    NSLog(@"value change:%f",slider.value);
    
    if (slider.value == 0.000000) {
        __weak typeof(self) weakSelf = self;
        [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.playerView.player play];
        }];
    }
}

- (void)videoSliderTouchChangeValueEnd:(UISlider *)slider {
    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        [weakSelf.playerView.player play];
        weakSelf.playBtn.selected = YES;
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.playBtn.alpha = 0;
            self.progressView.alpha = 0;
            self.titleBackView.alpha = 0;
        }];
    });
}

// 缓存时间算法
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    // 防止循环引用
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf.videoSlider setValue:currentSecond animated:YES];
        NSString *timeString = [weakSelf convertTime:currentSecond];
        weakSelf.timeProgressLabel.text = timeString;
    }];
}
// 自定义方法实现
- (void)customVideoSlider:(CMTime)duration {
    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}

// 时间转换
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@" HH:mm:ss "];
    } else {
        [[self dateFormatter] setDateFormat:@" mm:ss "];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}
- (void)clickPlayBtn:(UIButton *)sender {
    self.playBtn.selected =! self.playBtn.isSelected;
    if (self.playBtn.selected) {
        [self.playerView.player play];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.playBtn.alpha = 0;
                self.progressView.alpha = 0;
                self.titleBackView.alpha = 0;
            }];
        });
        
    } else {
        [self.playerView.player pause];
        self.playBtn.alpha = 1;
        self.progressView.alpha = 1;
        self.titleBackView.alpha = 1;
    }
}

- (void)clickBackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)moviePlayDidEnd:(NSNotificationCenter *)notification {
    NSLog(@"play end");
}

- (void)tapViewController:(UITapGestureRecognizer *)sender {
    self.playBtn.alpha = 1;
    self.progressView.alpha = 1;
    self.titleBackView.alpha = 1;
    
    if (self.playBtn.selected) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.playBtn.alpha = 0;
                self.progressView.alpha = 0;
                self.titleBackView.alpha = 0;
            }];
        });
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.playBtn.alpha = 0;
            self.progressView.alpha = 0;
            self.titleBackView.alpha = 0;
            
        }];
    });
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
