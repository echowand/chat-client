//
//  ChatTableViewController.m
//  chat-client
//
//  Created by Guanqun Mao on 9/16/15.
//  Copyright (c) 2015 Guanqun Mao. All rights reserved.
//

#import "ChatTableViewController.h"
#import "AppDelegate.h"

@interface ChatTableViewController ()

@end

@implementation ChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(onTimer) userInfo:nil repeats:YES];

}

- (void) onTimer {
    // Add code to be run periodically
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu msg.", (unsigned long)objects.count);
            // Do something with the found objects
            self.chatArray = objects;
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self.tableView reloadData];
    //NSLog(@"-------------onTimer");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.chatArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyChatCell" forIndexPath:indexPath];
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyChatCell"];
    // Configure the cell...
    NSDictionary *item = self.chatArray[indexPath.row];
    //cell.textLabel.text = item[@"text"];
    NSLog(@"item ----- %@", item);
    cell.chatText.text = item[@"text"];
    
    if ([item objectForKey:@"user"] && (item[@"user"]!=nil)) {
        NSLog(@"item user----- %@", item[@"user"]);
        if ([item[@"user"] class] == [PFUser class]){
            PFUser *pfuser = (PFUser*)item[@"user"];
            if((pfuser!=nil) && (pfuser.username!=nil)){
                @try {
                    cell.user.text = pfuser.username;
                }
                @catch (NSException *exception) {
                    NSLog(@"ERROR: username not found");
                }
                @finally {
                    
                }
                
            }
        }
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
    NSLog(@"MSG----------%@", self.msg.text);
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.msg.text;
    PFUser *user = [PFUser currentUser];
    message[@"user"] = user;

    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
            NSString *errorString = [error userInfo][@"error"];
        }
    }];
}
@end
