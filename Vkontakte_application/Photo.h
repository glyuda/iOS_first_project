//
//  Photo.h
//  Vkontakte_application
//
//  Created by Student on 7/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import UIKit;

@class PhotoAlbum, Post, User;

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSManagedObject

@property (readonly) UIImage *image;

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
