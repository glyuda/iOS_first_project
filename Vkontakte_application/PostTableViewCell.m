//
//  PostTableViewCell.m
//  Vkontakte_application
//
//  Created by Student on 7/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "PostTableViewCell.h"

#import "Photo.h"
#import "Post.h"

@implementation PostTableViewCell {

}

- (void) layoutSubviews{
    [super layoutSubviews];
    //create objects
    
    if (self.postImageView == nil) {
        [self setPostImageView:[[UIImageView alloc] init]];
        [self.postImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self setTextView:[[UITextView alloc] init]];
        //add on ierarhy
        [self addSubview:self.postImageView];
        [self addSubview:self.textView];
    };
    
    self.postImageView.image = self.post.image;
    self.postImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.postImageView.image.size.height);
    self.textView.frame = CGRectMake(0, CGRectGetMaxY(self.postImageView.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.postImageView.frame));
    
    self.textView.text = self.post.text;
}

@end
