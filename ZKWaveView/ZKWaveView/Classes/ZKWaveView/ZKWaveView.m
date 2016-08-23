


//
//  ZKWaveView.m
//  ZKWaveView
//
//  Created by ZK on 16/8/23.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKWaveView.h"

@interface ZKWaveView()

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation ZKWaveView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _speed = 0.7f;
    _waveSpeed = 1.5f;
    _waveHeight = 5.f;
    _realWaveColor = [UIColor whiteColor];
    _maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:.4f];
    
    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
    
    [self addSubview:self.iconImageView];
    [self startWaveAnimation];
}

#pragma mark - Public

- (void)startWaveAnimation
{
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleTimer)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWaveAnimation
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Timer

- (void)handleTimer
{
    _offset += _speed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGMutablePathRef realPath = CGPathCreateMutable();
    CGPathMoveToPoint(realPath, NULL, 0, height);
    CGFloat y = 0.f;
    for (CGFloat x=0.f; x<=width; x++) {
        y = height * sinf(0.01 * _waveSpeed * x + _offset * 0.045);
        CGPathAddLineToPoint(realPath, NULL, x, y);
    }
    CGFloat centerX = self.bounds.size.width * 0.5;
    CGFloat centerY = height * sinf(0.01 * _waveSpeed * centerX + _offset * 0.045);
    CGRect iconFrame = _iconImageView.frame;
    iconFrame.origin.y = centerY - 60.f;
    _iconImageView.frame = iconFrame;
    
    CGPathAddLineToPoint(realPath, NULL, width, height);
    CGPathAddLineToPoint(realPath, NULL, 0, height);
    CGPathCloseSubpath(realPath);
    _realWaveLayer.path = realPath;
    _realWaveLayer.fillColor = _realWaveColor.CGColor;
    CGPathRelease(realPath);
    
    // 遮罩浪
    CGMutablePathRef maskPath = CGPathCreateMutable();
    CGPathMoveToPoint(maskPath, NULL, 0, height);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= width; x ++) {
        maskY = height * cosf(0.01 * _waveSpeed * x + _offset * 0.045);
        CGPathAddLineToPoint(maskPath, NULL, x, maskY);
    }
    CGPathAddLineToPoint(maskPath, NULL, width, height);
    CGPathAddLineToPoint(maskPath, NULL, 0, height);
    CGPathCloseSubpath(maskPath);
    _maskWaveLayer.path = maskPath;
    _maskWaveLayer.fillColor = _maskWaveColor.CGColor;
    CGPathRelease(maskPath);
}

#pragma mark - Lazy Loading

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        CGFloat iconWidth = 60.f;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*0.5-iconWidth*0.5,
                                                                       -iconWidth,
                                                                       iconWidth,
                                                                       iconWidth)];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImageView.layer.borderWidth = 1.5f;
        _iconImageView.layer.cornerRadius = 20.f;
    }
    return _iconImageView;
}

- (CAShapeLayer *)realWaveLayer
{
    if (!_realWaveLayer) {
        _realWaveLayer = [CAShapeLayer layer];
        _realWaveLayer.frame = self.bounds;
        _realWaveLayer.fillColor = _realWaveColor.CGColor;
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer
{
    if (!_maskWaveLayer) {
        _maskWaveLayer = [CAShapeLayer layer];
        _maskWaveLayer.frame = self.bounds;
        _maskWaveLayer.fillColor = _maskWaveColor.CGColor;
    }
    return _maskWaveLayer;
}

@end
