//
//  iphoneAppDelegate.m
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iphoneAppDelegate.h"

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
  
  uploadThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
  [uploadThread setName:@"UploadThread"];
  [uploadThread start];
  [uploadThread release];
}

- (void)run{
	// Rails resource.
	[ObjectiveResourceConfig setSite:@"http://192.168.1.191:3000/"];
	[ObjectiveResourceConfig setResponseType:JSONResponse];
  
  while (TRUE) {
    NSLog(@"uploading");
    NSAutoreleasePool* myAutoreleasePool = [[NSAutoreleasePool alloc] init];
    for (User *user in [User findByCriteria:@"where uploaded = 0"]) {
      NSLog(@"upload user:%@", [user name]);
      [user setUploaded:[NSNumber numberWithInt:1]];
      [user saveRemote];
      [user save];
    }
    [myAutoreleasePool release];
    [NSThread sleepForTimeInterval:3];
  }
}

- (void)dealloc {
	[navigationController release];
  [window release];
  [super dealloc];
}


@end
