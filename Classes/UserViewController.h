//
//  UserViewController.h
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAddController.h"
#import "User.h"

@interface UserViewController : UITableViewController <UserAddDelegate> {
	
	NSMutableArray *usersArray;
	UIBarButtonItem *addButton;

}

@property (nonatomic, retain) NSMutableArray *usersArray;
@property (nonatomic, retain) UIBarButtonItem *addButton;

- (void)addUser;

@end
