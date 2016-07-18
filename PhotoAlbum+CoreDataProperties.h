//
//  PhotoAlbum+CoreDataProperties.h
//  
//
//  Created by Student on 7/18/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoAlbum.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAlbum (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) NSString *description_text;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) User *owner;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) Photo *thumbnail;

@end

@interface PhotoAlbum (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END
