//
//  ChatTableViewController.h
//  chat-client
//
//  Created by Guanqun Mao on 9/16/15.
//  Copyright (c) 2015 Guanqun Mao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatCell.h"

@interface ChatTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *msg;
@property NSArray *chatArray;
- (IBAction)saveButton:(id)sender;

@end
