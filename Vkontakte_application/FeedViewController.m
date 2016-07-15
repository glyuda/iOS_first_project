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


@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"authKey"];
    [DataManager GETRequestWithURL:@"https://api.vk.com/method/newsfeed.get"
                        parameters:@{@"access_token" : token}
                           handler:^(NSData *data, NSURLResponse *response, NSError *error) {
                               //1. Create a new class - FeedItem
                               
                               NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               
                               NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               NSArray *feedItems = responseDict[@"response"][@"profiles"];
                               
                               for (NSDictionary *itemDictionary in feedItems) {
                                   User *object =[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[NSManagedObjectContext defaultContext]];
                                   //get the data
                                   object.id = itemDictionary[@"uid"];
                                   object.first_name = itemDictionary[@"first_name"];
                                   object.last_name = itemDictionary[@"last_name"];
                                   
                               }
                               
                               for (NSDictionary *attachmentDict in feedItems) {
                               
                               }
                               
                               //save changess
                               [[NSManagedObjectContext defaultContext] save:nil];
                               
                           }];
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
