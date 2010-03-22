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
#define topMargin  68.0
#define textHeight  28.0


@implementation UserAddController

@synthesize nameLabel, nameText, delegate;

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
  
	self.title = @"新增用户信息";
  
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

  [self.view addSubview:nameText];
  [self.view addSubview:nameLabel];
  
  //focus
  [nameText becomeFirstResponder];
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
  User *user = [[User alloc] init];
  [user setName:nameText.text];
  [user setUploaded:[NSNumber numberWithInt:0]];
  [user save];
  [user release];
  
  [self.delegate userAddController:self didAdd:user];
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
  
  [self.navigationController popViewControllerAnimated:YES];
  
	return YES;
}

- (void)dealloc {
  [nameLabel release];
  [nameText release];
  [super dealloc];
}


@end
