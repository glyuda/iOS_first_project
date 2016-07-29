//
//  Photo.m
//  Vkontakte_application
//
//  Created by Student on 7/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "Photo.h"
#import "PhotoAlbum.h"
#import "Post.h"
#import "User.h"

@implementation Photo

- (UIImage *) image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths[0];
    NSString *fullPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", self.filepath]];///????
    UIImage *result = [UIImage imageWithContentsOfFile:fullPath];
    return result;
}

// Insert code here to add functionality to your managed object subclass

@end
