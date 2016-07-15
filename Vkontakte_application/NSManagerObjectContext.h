//
//  NSManagerObjectContext.h
//  Vkontakte_application
//
//  Created by Student on 7/15/16.
//  Copyright © 2016 Student. All rights reserved.
//

@import CoreData;

@interface NSManagedObjectContext (EasyAccess)
+ (NSManagedObjectContext *) defaultContext;

@end
