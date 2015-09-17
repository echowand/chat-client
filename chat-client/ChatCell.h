//
//  ChatCell.h
//  chat-client
//
//  Created by Guanqun Mao on 9/16/15.
//  Copyright (c) 2015 Guanqun Mao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatText;
@property (weak, nonatomic) IBOutlet UILabel *user;

@end
