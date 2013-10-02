//
//  JSAppDelegate.m
//  Dynamic Type
//
//  Created by John Szumski
//  Copyright (c) 2013 CapTech Consulting. All rights reserved.
//

#import "JSAppDelegate.h"
#import "JSTableViewController.h"
#import "JSScrollViewController.h"
#import "JSViewController.h"

@implementation JSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	UINavigationController *tableNav = [[UINavigationController alloc] initWithRootViewController:[[JSTableViewController alloc] init]];
	UINavigationController *scrollNav = [[UINavigationController alloc] initWithRootViewController:[[JSScrollViewController alloc] init]];
	UINavigationController *viewNav = [[UINavigationController alloc] initWithRootViewController:[[JSViewController alloc] init]];
	
	UITabBarController *tabController = [[UITabBarController alloc] init];
	tabController.viewControllers = @[tableNav, scrollNav, viewNav];
	
	self.window.rootViewController = tabController;
    [self.window makeKeyAndVisible];
    
	return YES;
}

@end