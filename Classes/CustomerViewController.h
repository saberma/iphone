//
//  CustomerViewController.h
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerAddController.h"
#import "Customer.h"

@interface CustomerViewController : UITableViewController <CustomerAddDelegate> {
	
	NSMutableArray *customersArray;
	UIBarButtonItem *addButton;

}

@property (nonatomic, retain) NSMutableArray *customersArray;
@property (nonatomic, retain) UIBarButtonItem *addButton;

- (void)addCustomer;

@end
