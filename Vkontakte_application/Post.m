//
//  Post.m
//  Vkontakte_application
//
//  Created by Student on 7/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "Post.h"
#import "Photo.h"
#import "User.h"
@import UIKit;

@implementation Post {

}

- (UIImage *) image {
    Photo *photo = [self.photos anyObject];
    return photo.image;
}

// Insert code here to add functionality to your managed object subclass

@end
