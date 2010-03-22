//
//  UserAddController.h
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol UserAddDelegate;

@interface UserAddController : UIViewController<UITextFieldDelegate> {

	UILabel *nameLabel;
	UITextField *nameText;
  id <UserAddDelegate> delegate;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UITextField *nameText;
@property (nonatomic, assign) id <UserAddDelegate> delegate;

- (void) save;

@end


@protocol UserAddDelegate <NSObject>

- (void)userAddController:(UserAddController *) userAddController didAdd:(User *)user;

@end