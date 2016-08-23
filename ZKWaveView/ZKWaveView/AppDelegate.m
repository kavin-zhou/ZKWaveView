//
//  AppDelegate.m
//  ZKWaveView
//
//  Created by ZK on 16/8/23.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "AppDelegate.h"
#import "ZKMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ZKMainViewController *vc = [[ZKMainViewController alloc] init];
    self.window.rootViewController = vc;
    
    return YES;
}

@end
