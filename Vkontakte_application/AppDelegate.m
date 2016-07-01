//
//  AppDelegate.m
//  Vkontakte_application
//
//  Created by Student on 6/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUpViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    
    //create ViewController
    SignUpViewController *viewController = [[SignUpViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: viewController];
    
    [[self window] setRootViewController:navController];
    navController.navigationBar.barTintColor = [UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:1];
    navController.navigationBar.translucent = NO;
    //set button's font color
    navController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[self window] makeKeyAndVisible];
    return YES;
}

@end
