//
//  Photo+CoreDataProperties.h
//  Vkontakte_application
//
//  Created by Student on 7/15/16.
//  Copyright © 2016 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"
#import "PhotoAlbum.h"
#import "User.h"


NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSNumber *width;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) PhotoAlbum *album;
@property (nullable, nonatomic, retain) User *owner;
@property (nullable, nonatomic, retain) NSManagedObject *albumCover;

@end

NS_ASSUME_NONNULL_END
