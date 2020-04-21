//
//  AppDelegate.m
//  exam
//
//  Created by CC on 2020/4/8.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[HomeViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
