//
//  DataManager.h
//  Vkontakte_application
//
//  Created by Student on 7/4/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataManager : UIViewController
+ (void)POSTRequestWithURL:(NSString *)url
                parameters:(NSDictionary *)params
                   handler:(void (^)(NSData *, NSURLResponse *, NSError *))handler;
+ (void)GETRequestWithURL:(NSString *)url
                parameters:(NSDictionary *)params
                   handler:(void (^)(NSData *, NSURLResponse *, NSError *))handler;
@end
