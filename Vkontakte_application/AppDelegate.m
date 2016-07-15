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



@import CoreData;

@interface AppDelegate ()<VKSdkDelegate, VKSdkUIDelegate>

@property (strong, nonatomic) VKSdk *sdkInstance;

@end

@implementation AppDelegate

//required methods from VKSdkDelegate
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
//	    
    if (result.token != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:result.token.accessToken forKey:@"authKey"];
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
    NSArray *SCOPE = @[@"friends", @"email", @"wall"];
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationInitialized) {
            // Authorized and ready to go
            [VKSdk authorize:SCOPE withOptions:VKAuthorizationOptionsDisableSafariController];
        } else {
            //
        } 
    }];
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //CoreData
    [self initializeCoreData];
    
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
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: viewController];
        [[self window] setRootViewController:navController];
        
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

- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
    
    
    
}

@end
