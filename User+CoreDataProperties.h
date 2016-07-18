//
//  User+CoreDataProperties.h
//  
//
//  Created by Student on 7/18/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *first_name;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *last_name;
@property (nullable, nonatomic, retain) NSSet<PhotoAlbum *> *albums;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) Post *posts;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAlbumsObject:(PhotoAlbum *)value;
- (void)removeAlbumsObject:(PhotoAlbum *)value;
- (void)addAlbums:(NSSet<PhotoAlbum *> *)values;
- (void)removeAlbums:(NSSet<PhotoAlbum *> *)values;

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

@end

NS_ASSUME_NONNULL_END
