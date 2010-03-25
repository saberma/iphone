//
//  iphoneAppDelegate.h
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveResource.h"
#import "UserViewController.h"

@interface iphoneAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void) applicationDidFinishLaunching: (UIApplication *) application;

@end

