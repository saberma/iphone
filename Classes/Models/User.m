//
//  User.m
//  iphone
//
//  Created by  cogent on 10-3-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize name, userId;
@synthesize uploaded;
@synthesize photo;

- (void)dealloc {
  [name release];
  [userId release];
  [uploaded release];
  [photo release];
  [super dealloc];
}

@end
