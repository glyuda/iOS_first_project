//
//  NSManagerObjectContext.m
//  Vkontakte_application
//
//  Created by Student on 7/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "NSManagerObjectContext.h"
#import "AppDelegate.h"

@implementation NSManagedObjectContext (EasyAccess)
+ (NSManagedObjectContext *) defaultContext {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return delegate.managedObjectContext;
}

@end
