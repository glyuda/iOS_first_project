//
//  AppDelegate.h
//  Vkontakte_application
//
//  Created by Student on 6/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VKSdk.h>	

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) NSManagedObjectContext *managedObjectContext;

- (void)vkAuthorize;
- (void)initializeCoreData;

@end

