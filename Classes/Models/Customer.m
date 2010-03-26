//
//  Customer.m
//  iphone
//
//  Created by  cogent on 10-3-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Customer.h"


@implementation Customer

@synthesize name, customerId;
@synthesize uploaded, deleted;
@synthesize photo;

- (void)dealloc {
  [name release];
  [customerId release];
  [uploaded release];
  [deleted release];
  [photo release];
  [super dealloc];
}

@end
