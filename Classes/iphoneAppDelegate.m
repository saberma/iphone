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
	
	CustomerViewController *customerViewController = [[CustomerViewController alloc]
											  initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc]
													 initWithRootViewController:customerViewController];
	self.navigationController = aNavigationController;
	
	[window addSubview:[navigationController view]];
  // Override point for customization after application launch
  [window makeKeyAndVisible];
	[customerViewController release];
	[aNavigationController release];
  
  /*
   */
  NSThread *uploadThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
  [uploadThread setName:@"UploadThread"];
  [uploadThread start];
  [uploadThread release];
}

- (void)run{
	// Rails resource.
	[ObjectiveResourceConfig setSite:@"http://192.168.1.191:3000/zbs/"];
	[ObjectiveResourceConfig setResponseType:JSONResponse];
  
  while (TRUE) {
    @try {
      NSLog(@"uploading");
      NSAutoreleasePool* myAutoreleasePool = [[NSAutoreleasePool alloc] init];
      for (Customer *customer in [Customer findByCriteria:@"where uploaded = 0"]) {
        //删除
        //NSLog([customer.deleted de]);
        if ([customer.deleted intValue] == 1) {
          NSLog(@"delete customer(%@):%@", [customer customerId], [customer name]);
          if ([customer destroyRemote]) {
            [customer deleteObject];
            NSLog(@"delete success! customer:%@", [customer name]);
          }
        //新增或更新
        }else {
          NSLog(@"save customer(%@):%@", [customer customerId], [customer name]);
          if ([customer saveRemote]) {
            [customer setUploaded:[NSNumber numberWithInt:1]];
            [customer save];
            NSLog(@"upload success! customer:%@", [customer name]);
          }
        }

      }
      [myAutoreleasePool release];
      [NSThread sleepForTimeInterval:8];
    }
    @catch (NSException * e) {
      NSLog(@"Thread Error!");
    }
    @finally {
      
    }
  }
}

- (void)dealloc {
	[navigationController release];
  [window release];
  [super dealloc];
}


@end
