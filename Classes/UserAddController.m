//
//  UserAddController.m
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserAddController.h"
#define labelWidth 80.0
#define textWidth 150.0
#define leftMargin  20.0
#define topMargin  88.0
#define textHeight  28.0


@implementation UserAddController

@synthesize user, nameLabel, nameText, photoButton, delegate, photoImageView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 //allocate the view
 self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
 
 //set the view's background color
 self.view.backgroundColor = [UIColor whiteColor];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
  
	self.title = [NSString stringWithFormat:@"%@用户", user.pk > -1 ? @"修改" : @"新增"];
  
  //photo button
  CGRect buttonFrame = CGRectMake(leftMargin + labelWidth + 15, topMargin - textHeight - 15, labelWidth, textHeight);
  UIButton *aButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
  [aButton setFrame:buttonFrame];
  [aButton setTitle:@"拍照" forState:UIControlStateNormal];
  [aButton addTarget:self action:@selector(applyPhoto:) forControlEvents:UIControlEventTouchUpInside];
  self.photoButton = aButton;
  [aButton release];
  
  //photo view
  CGRect viewFrame = CGRectMake(leftMargin, topMargin - (textHeight * 3), labelWidth, textHeight * 3 - 10);
  UIImageView *aView = [[UIImageView alloc] initWithFrame:viewFrame];
  self.photoImageView = aView;
  [aView release];
  
  //label
  CGRect frame = CGRectMake(leftMargin, topMargin, labelWidth, textHeight);
  UILabel *aLabel = [[UILabel alloc] initWithFrame:frame];
  [aLabel setText:@"用户名"];
  self.nameLabel = aLabel;
  [aLabel release];
   
  //text
  CGRect textFrame = CGRectMake(leftMargin + labelWidth, topMargin, textWidth, textHeight);
  UITextField *aText = [[UITextField alloc] initWithFrame:textFrame];
  aText.backgroundColor = [UIColor whiteColor];
  aText.borderStyle = UITextBorderStyleRoundedRect;
  aText.delegate = self;
  self.nameText = aText;
  [aText release];
  
  //save button
  UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
  self.navigationItem.rightBarButtonItem = saveButtonItem;
  [saveButtonItem release];
  
  [self.view addSubview:photoImageView];
  [self.view addSubview:photoButton];
  [self.view addSubview:nameText];
  [self.view addSubview:nameLabel];
  
  //show user info while edit
  self.nameText.text = [user name];
  self.photoImageView.image = [user photo];
  
  //focus
  [nameText becomeFirstResponder];
}

- (void)applyPhoto:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	if ( (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])) {
		NSLog(@"....without camera....");
	}else {
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  }

  imagePicker.delegate = self;
  [self presentModalViewController:imagePicker animated:YES];
  [imagePicker release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

//保存数据
- (void)save {
  [user setName:nameText.text];
  [user setUploaded:[NSNumber numberWithInt:0]];
  [user setPhoto:photoImageView.image];
  [user save];
  
  [self.delegate userAddController:self didAdd:user];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if (textField == nameText) {
    // the user pressed the "Done" button, so dismiss the keyboard
    [nameText resignFirstResponder];
    [self save];
  }
  
	return YES;
}

- (void)updatePhotoInfo: (UIImage *)selectedImage {
	
	// Synchronize the photo image view and the text on the photo button with the event's photo.
	UIImage *image = selectedImage;
	photoImageView.image = image;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
	
	// Create a thumbnail version of the image for the event object.
	CGSize size = selectedImage.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = 44.0 / size.width;
	}
	else {
		ratio = 44.0 / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	[selectedImage drawInRect:rect];
	
	// Update the user interface appropriately.
	[self updatePhotoInfo:selectedImage];
  
  [self dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	// The user canceled -- simply dismiss the image picker.
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
  [user  release];
  [nameLabel release];
  [nameText release];
	[photoButton release];
	[photoImageView release];
  [super dealloc];
}


@end
