//
//  Customer.h
//  iphone
//
//  Created by  cogent on 10-3-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"


@interface Customer : SQLitePersistentObject {

  NSString *name;
  NSNumber *customerId, *uploaded, *deleted;
  UIImage *photo;
}

//customerId is for objectresource
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *customerId, *uploaded, *deleted;

@property (nonatomic, retain) UIImage *photo;

@end
