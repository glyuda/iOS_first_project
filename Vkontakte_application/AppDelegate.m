//
//  AppDelegate.m
//  Vkontakte_application
//
//  Created by Student on 6/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "FeedViewController.h"

@interface AppDelegate ()<VKSdkDelegate, VKSdkUIDelegate>

@property (strong, nonatomic) VKSdk *sdkInstance;

@end

@implementation AppDelegate

//required methods from VKSdkDelegate
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
//	    
    if (result.token != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:result.token.accessToken forKey:@"authToken"];
    }
    NSLog(@"%@", result);
};

//
- (void)vkSdkUserAuthorizationFailed {
//
    NSLog(@"Authorization Failed...");
};

//required methods from VKSdkUIDelegate
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
//
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
    NSLog(@"%@", controller);
};

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
//
    NSLog(@"%@", captchaError);
};

//Our method for the authorization
- (void)vkAuthorize {
    //[VKSdk authorize:VKParseVkPermissionsFromInteger(134217728) withOptions:0];
    NSArray *SCOPE = @[@"friends", @"email"];
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationInitialized) {
            // Authorized and ready to go
            [VKSdk authorize:VKParseVkPermissionsFromInteger(134217728) withOptions:VKAuthorizationOptionsDisableSafariController];
        } else {
            //
        } 
    }];
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //VK.com
    self.sdkInstance = [VKSdk initializeWithAppId:@"5534154"];
    [self.sdkInstance registerDelegate:self];
    [self.sdkInstance setUiDelegate:self];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    
    
    
    //If authorixed - show news, else - sign up
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"authKey"];
    if (token) {
        FeedViewController *viewController = [[FeedViewController alloc] init];
        
    }
    else {
        //create ViewController
        SignUpViewController *viewController = [[SignUpViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: viewController];
        [[self window] setRootViewController:navController];
        
        navController.navigationBar.barTintColor = [UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:1];
        navController.navigationBar.translucent = NO;
        //set button's font color
        navController.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    [[self window] makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return YES;
}

@end
