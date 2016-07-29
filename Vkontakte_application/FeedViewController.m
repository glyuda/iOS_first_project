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
#import "UIImageView+AFNetworking.h"


@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView setEstimatedRowHeight:120];
    
    //[tableView registerClass:[PostTableViewCell class] forCellReuseIdentifier:@"PostTableViewCell"];
    UINib *nib = [UINib nibWithNibName:@"PostTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:@"PostTableViewCell"];
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
                                   Post *postObject = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];
                                   postObject.id = itemsDict[@"post_id"];
                                   postObject.date = nil; //itemsDict[@"date"];
                                   postObject.post_type = itemsDict[@"post_type"];
                                   postObject.text = itemsDict[@"text"];
                                   for (NSDictionary *attachmentDictionary in attachments) {
                                       
                                       NSString *attachmentType = attachmentDictionary[@"type"];
                                       if ([attachmentType isEqualToString:@"photo"]) {
                                           NSDictionary *photoSource = attachmentDictionary[@"photo"];
                                           //get photo's id
                                           NSNumber *photoId = photoSource[@"pid"];
                                           //search this photo by id
                                           NSFetchRequest *fetchPhotoRequest = [NSFetchRequest  fetchRequestWithEntityName:@"Photo"];
                                           fetchPhotoRequest.predicate = [NSPredicate predicateWithFormat:@"id == %@", photoId];
                                           [fetchPhotoRequest setFetchLimit:1];
                                           
                                           NSArray *photoArray = [context executeFetchRequest:fetchPhotoRequest error:nil];
                                           Photo *photoObject = [photoArray firstObject];
                                           
                                           photoObject = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
                                           photoObject.id = photoSource[@"pid"];
                                           photoObject.url = photoSource[@"src"];
                                           photoObject.width = photoSource[@"width"];
                                           photoObject.height = photoSource[@"height"];
                                           photoObject.text = photoSource[@"text"];
                                           photoObject.created = nil; //attachmentDictionary[@"date"];
                                           photoObject.album = nil; //attachmentDictionary[@"album_id"];
                                           photoObject.albumCover = nil; //???
                                           
                                           [postObject addPhotosObject:photoObject];
                                           [photoObject setFeedPhoto:postObject];
                                           
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

                                       } //end if
                                   } //end for attachmentDictionary
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
    //    Post *post = self.items[indexPath.row];
    //    Photo *photo = [post.photos anyObject];
    //
    //    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo.url]];
    //    UIImage *image = [UIImage imageWithData:data];
    //    NSString *text = post.text;
    //    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    //    NSDictionary *attributes = @{NSFontAttributeName: font};
    //
    //    CGRect rect = [text boundingRectWithSize:CGSizeMake(tableView.frame.size.width, CGFLOAT_MAX) options:0 attributes:attributes context:nil];
    //    return rect.size.height + image.size.height;
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Post *post = self.items[indexPath.row];
    Photo *photo = [[post photos] anyObject];
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell" forIndexPath:indexPath];
    NSURL *photoUrl = [NSURL URLWithString:photo.url];
    [[cell postImageView] setImageWithURL:photoUrl];
    
    cell.textView.attributedText = [[NSAttributedString alloc] initWithData:[post.text dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                         documentAttributes:nil error:nil];
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
