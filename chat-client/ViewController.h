//
//  ViewController.h
//  chat-client
//
//  Created by Guanqun Mao on 9/16/15.
//  Copyright (c) 2015 Guanqun Mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;

- (IBAction)signupButton:(id)sender;
- (IBAction)signinButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;


@end

