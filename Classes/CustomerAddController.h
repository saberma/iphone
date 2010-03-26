//
//  CustomerAddController.h
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"

@protocol CustomerAddDelegate;

@interface CustomerAddController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
  Customer *customer;
	UILabel *nameLabel;
	UITextField *nameText;
	UIButton *photoButton;
  id <CustomerAddDelegate> delegate;
	UIImageView *photoImageView;
}

@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UITextField *nameText;
@property (nonatomic, retain) UIButton *photoButton;
@property (nonatomic, assign) id <CustomerAddDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;

- (void)save;
- (void)applyPhoto:(id)sender;
- (void)updatePhotoInfo:(UIImage *)selectedImage;

@end


@protocol CustomerAddDelegate <NSObject>

- (void)customerAddController:(CustomerAddController *) customerAddController didAdd:(Customer *)customer;

@end