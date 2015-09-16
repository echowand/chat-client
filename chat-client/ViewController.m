//
//  ViewController.m
//  chat-client
//
//  Created by Guanqun Mao on 9/16/15.
//  Copyright (c) 2015 Guanqun Mao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupButton:(id)sender {
    
    NSLog(@"username %@", self.username.text);
    NSLog(@"password %@", self.password.text);
    NSLog(@"email %@", self.email.text);
    [self myMethod];
}

- (IBAction)signinButton:(id)sender {
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [self performSegueWithIdentifier:@"com.yahoo.parse.list" sender:self];
                                            });
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSString *errorString = [error userInfo][@"error"];
                                        }
                                    }];
}

- (void)myMethod {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    user.email = self.email.text;
    
    // other fields can be set just like with PFObject
    user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"com.yahoo.parse.list" sender:self];
            });
        } else {
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
        }
    }];
}



@end
