//
//  FeedViewController.m
//  Vkontakte_application
//
//  Created by Student on 7/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "DataManager.h"
#import "FeedViewController.h"
#import "NSManagerObjectContext.h"
#import "User.h"
#import "Photo.h"
#import "Post.h"
#import "PostTableViewCell.h"


@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:@"PostTableViewCell"];
    [[self view] addSubview:tableView];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"authKey"];
    [DataManager GETRequestWithURL:@"https://api.vk.com/method/newsfeed.get"
                        parameters:@{@"access_token" : token}
                           handler:^(NSData *data, NSURLResponse *response, NSError *error) {
                               //1. Create a new class - FeedItem
                               
                               NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               
                               NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               NSArray *feedItems = responseDict[@"response"][@"profiles"];
                               
                               NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
                               
                               //parsing User's data
                               for (NSDictionary *itemDictionary in feedItems) {
                                   User *object =[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
                                   //get the data
                                   object.id = itemDictionary[@"uid"];
                                   object.first_name = itemDictionary[@"first_name"];
                                   object.last_name = itemDictionary[@"last_name"];
                               }
                               
                               //parsing photos
                               for (NSDictionary *itemsDict in responseDict[@"response"][@"items"]) {
                                   NSArray *attachments = itemsDict[@"attachments"];
                                   
                                   for (NSDictionary *attachmentDictionary in attachments) {
                                       
                                       NSString *attachmentType = attachmentDictionary[@"type"];
                                       if ([attachmentType isEqualToString:@"photo"]) {
                                           //create Photo as we did for User early
                                           Photo *photoObject = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
                                           
                                           NSDictionary *photoSource = attachmentDictionary[@"photo"];
                                           
                                           photoObject.id = photoSource[@"pid"];
                                           photoObject.url = photoSource[@"src"];
                                           photoObject.width = photoSource[@"width"];
                                           photoObject.height = photoSource[@"height"];
                                           photoObject.text = photoSource[@"text"];
                                           photoObject.created = nil; //attachmentDictionary[@"date"];
                                           photoObject.album = nil; //attachmentDictionary[@"album_id"];
                                           photoObject.albumCover = nil; //???
                                           
                                           //get photo's owner
                                           NSNumber *ownerId = photoSource[@"owner_id"];
                                           //search this user by id
                                           NSFetchRequest *fetchRequest = [NSFetchRequest  fetchRequestWithEntityName:@"User"];
                                           fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id == %@", ownerId];
                                           [fetchRequest setFetchLimit:1];
                                           
                                           NSArray *array = [context executeFetchRequest:fetchRequest error:nil];
                                           User *owner = [array firstObject];
                                           
                                           //create link between User and Photo
                                           if (owner != nil) {
                                               [owner addPhotosObject:photoObject];
                                               [photoObject setOwner:owner];
                                           }
                                       }
                                   }
                               }
                               
                               //parsing posts
                               for (NSDictionary *itemsDict in responseDict[@"response"][@"items"]) {
                                   Post *postObject = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
                                   postObject.id = itemsDict[@"post_id"];
                                   postObject.date = nil; //itemsDict[@"date"];
                                   postObject.post_type = itemsDict[@"post_type"];
                                   postObject.text = itemsDict[@"text"];
                                   
                                   
                                   for (NSDictionary *attachmentDictionary in itemsDict[@"attachments"]) {
                                       //get photo's id
                                       NSString *attachmentType = attachmentDictionary[@"type"];
                                       if ([attachmentType isEqualToString:@"photo"]) {
                                           Photo *photoObject = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
                                           photoObject.url = attachmentDictionary[@"photo"][@"src"];
                                           
                                           [postObject addPhotosObject:photoObject];
                                           [photoObject setFeedPhoto:postObject];
                                       }
                                   }
                               }
                               
                               //save changes
                               [[NSManagedObjectContext defaultContext] save:nil];
                               
                               NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Post"];
                               NSArray *array = [[NSManagedObjectContext defaultContext] executeFetchRequest:fetchRequest error:nil];
                               self.items = [array mutableCopy];
                               [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                           }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.items[indexPath.row];
    Photo *photo = [post.photos anyObject];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo.url]];
    UIImage *image = [UIImage imageWithData:data];
    NSString *text = post.text;
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(tableView.frame.size.width, CGFLOAT_MAX) options:0 attributes:attributes context:nil];
    return rect.size.height + image.size.height;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Post *post = self.items[indexPath.row];
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell" forIndexPath:indexPath];
    Photo *photo = [post.photos anyObject];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo.url]];
    [cell setPostImageView:[[UIImageView alloc] init]];
    [cell.postImageView setContentMode:UIViewContentModeScaleAspectFit];
    [cell setTextView:[[UITextView alloc] init]];
    //add on ierarhy
    [cell addSubview:cell.postImageView];
    [cell addSubview:cell.textView];
    
    UIImage *imageToDraw =[UIImage imageWithData:data];
    cell.postImageView.image = imageToDraw;
    cell.postImageView.frame = CGRectMake(0, 0, cell.frame.size.width, imageToDraw.size.height);
    cell.textView.frame = CGRectMake(0, CGRectGetMaxY(cell.postImageView.frame), cell.frame.size.width, cell.frame.size.height - CGRectGetMaxY(cell.postImageView.frame));
    
    cell.textView.text = post.text;
    [cell setNeedsLayout];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
