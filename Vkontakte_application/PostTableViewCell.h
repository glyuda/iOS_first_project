//
//  PostTableViewCell.h
//  Vkontakte_application
//
//  Created by Student on 7/22/16.
//  Copyright © 2016 Student. All rights reserved.
//

@import UIKit;
@class Post;

@interface PostTableViewCell : UITableViewCell
@property (nonatomic, retain) Post *post;
@property (nonatomic, retain) IBOutlet UIImageView *postImageView;
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
