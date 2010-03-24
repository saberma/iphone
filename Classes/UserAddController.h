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

@interface UserAddController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

	UILabel *nameLabel;
	UITextField *nameText;
	UIButton *photoButton;
  id <UserAddDelegate> delegate;
	UIImageView *photoImageView;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UITextField *nameText;
@property (nonatomic, retain) UIButton *photoButton;
@property (nonatomic, assign) id <UserAddDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;

- (void)save;
- (void)applyPhoto:(id)sender;
- (void)updatePhotoInfo:(UIImage *)selectedImage;

@end


@protocol UserAddDelegate <NSObject>

- (void)userAddController:(UserAddController *) userAddController didAdd:(User *)user;

@end