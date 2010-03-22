//
//  User.m
//  iphone
//
//  Created by  cogent on 10-3-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize name;

- (void)dealloc {
  [name release];
  [super dealloc];
}

@end
