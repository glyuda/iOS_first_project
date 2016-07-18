//
//  Post+CoreDataProperties.h
//  
//
//  Created by Student on 7/18/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSString *post_type;
@property (nullable, nonatomic, retain) User *owner;

@end

NS_ASSUME_NONNULL_END
