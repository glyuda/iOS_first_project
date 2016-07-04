//
//  LoginViewController.m
//  Vkontakte_application
//
//  Created by Student on 6/24/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "DataManager.h"
#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
- (void)sign_in {
// log in the system
}

- (void)submit {
//operation with data which input user
    NSDictionary *dictionary = @{
                                 @"first_name":self.firstNameTextField.text,
                                 @"last_name":self.lastNameTextField.text,
                                 @"client_id":@"5534154",
                                 @"client_secret":@"1Ct70CDyN7HOBlQtQ5qS",
                                 @"phone":self.phoneTextField.text,
                                 @"password":self.passwordTextField.text,
                                 @"test_mode":@1
                                 };
    [DataManager POSTRequestWithURL:@"https://api.vk.com/method/auth.signup"
                         parameters:dictionary
                            handler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
                                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                
                                id o = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                
                            }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//set background for application page
    //[self.view setBackgroundColor:[UIColor blueColor]];
    //set image
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"signup_background"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    //set blue overlay
    UIView *blueOverlay = [[UIView alloc] initWithFrame:imageView.bounds];
    [blueOverlay setBackgroundColor:[UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:0.85]];
    [imageView addSubview:blueOverlay];
    
    
//add title
    [self setTitle:@"New Account"];
    //change title's font color
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
//add button "Sign In"
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStyleDone target:self action:@selector(sign_in)];
    [self.navigationItem setLeftBarButtonItem:itemLeft];
    
//add button "Create"
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    [self.navigationItem setRightBarButtonItem:itemRight];
    
//add text field for the First Name
    self.firstNameTextField = [UITextField new];
    [self.firstNameTextField setFrame:CGRectMake(10, 20, self.view.frame.size.width-20, 30)];
    //add bottom border for text field
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.firstNameTextField.frame.size.height-1, self.firstNameTextField.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:1];
    [[self firstNameTextField] addSubview:bottomBorder];

    [self.view addSubview:self.firstNameTextField];
    NSAttributedString *firstNamePlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.firstNameTextField setAttributedPlaceholder:firstNamePlaceholder];
    [self.firstNameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
//add text field for the Last Name
    self.lastNameTextField = [UITextField new];
    [self.lastNameTextField setFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 30)];
    bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.lastNameTextField.frame.size.height-1, self.lastNameTextField.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:1];
    [[self lastNameTextField] addSubview:bottomBorder];
    
    [self.view addSubview:self.lastNameTextField];
    NSAttributedString *lastNamePlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.lastNameTextField setAttributedPlaceholder:lastNamePlaceholder];
    [self.lastNameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
//add text field for the Phone Number
    self.phoneTextField = [UITextField new];
    [self.phoneTextField setFrame:CGRectMake(10, 120, self.view.frame.size.width-20, 30)];
    bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.phoneTextField.frame.size.height-1, self.phoneTextField.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:1];
    [[self phoneTextField] addSubview:bottomBorder];
    [self.view addSubview:self.phoneTextField];
    NSAttributedString *phonePlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.phoneTextField setAttributedPlaceholder:phonePlaceholder];
    
//add text field for the Password
    self.passwordTextField = [UITextField new];
    [self.passwordTextField setFrame:CGRectMake(10, 170, self.view.frame.size.width-20, 30)];
    bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.passwordTextField.frame.size.height-1, self.passwordTextField.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:141.0f/255.0f alpha:1];
    [[self passwordTextField] addSubview:bottomBorder];
    [self.view addSubview:self.passwordTextField];
    NSAttributedString *passwordPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.passwordTextField setAttributedPlaceholder:passwordPlaceholder];
    [self.passwordTextField setSecureTextEntry:YES];
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
