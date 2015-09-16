//
//  ChatTableViewController.h
//  chat-client
//
//  Created by Guanqun Mao on 9/16/15.
//  Copyright (c) 2015 Guanqun Mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *msg;
- (IBAction)saveButton:(id)sender;

@end
