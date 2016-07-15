//
//  PhotoAlbum+CoreDataProperties.h
//  Vkontakte_application
//
//  Created by Student on 7/15/16.
//  Copyright © 2016 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoAlbum.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAlbum (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *description_text;
@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) Photo *thumbnail;
@property (nullable, nonatomic, retain) NSManagedObject *owner;

@end

@interface PhotoAlbum (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END
