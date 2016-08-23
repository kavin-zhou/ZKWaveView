//
//  ZKWaveView.h
//  ZKWaveView
//
//  Created by ZK on 16/8/23.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKWaveView : UIView

@property (nonatomic, assign) CGFloat waveSpeed;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, strong) UIColor *realWaveColor;
@property (nonatomic, strong) UIColor *maskWaveColor;

- (void)startWaveAnimation;
- (void)stopWaveAnimation;

@end
