//
//  iphoneAppDelegate.m
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iphoneAppDelegate.h"
#import "UserViewController.h"

@implementation iphoneAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application { 	
  
  window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.backgroundColor = [UIColor whiteColor];
	
	UserViewController *userViewController = [[UserViewController alloc]
											  initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc]
													 initWithRootViewController:userViewController];
	self.navigationController = aNavigationController;
	
	[window addSubview:[navigationController view]];
    // Override point for customization after application launch
    [window makeKeyAndVisible];
	[userViewController release];
	[aNavigationController release];
}


- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
