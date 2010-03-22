//
//  User.h
//  iphone
//
//  Created by  cogent on 10-3-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"


@interface User : SQLitePersistentObject {

  NSString *name;
}

@property (nonatomic, retain) NSString *name;

@end
