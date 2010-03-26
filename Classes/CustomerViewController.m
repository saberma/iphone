//
//  CustomerViewController.m
//  iphone
//
//  Created by  cogent on 10-3-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomerViewController.h"


@implementation CustomerViewController

@synthesize customersArray;
@synthesize	addButton;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */

- (void)viewDidLoad {
  [super viewDidLoad];
	self.title = @"客户";
	
  //[self.editButtonItem setTitle:@"修改"];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	addButton = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addCustomer)];
	self.navigationItem.rightBarButtonItem = addButton;
  
  
  
  self.customersArray = [[Customer allObjects] mutableCopy];
}

- (void)addCustomer {
	CustomerAddController *addController = [[CustomerAddController alloc] init];
  Customer *customer = [[Customer alloc] init];
  [addController setCustomer:customer];
  [addController setDelegate:self];
  
	[self.navigationController pushViewController:addController animated:YES];
   
  [addController release];
}

- (void)viewWillAppear:(BOOL)animated {
  [self.tableView reloadData];
  [super viewWillAppear:animated];
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

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
	self.customersArray = nil;
	self.addButton = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [customersArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  // Set up the cell...
  NSInteger row = [indexPath row];
  Customer *customer = (Customer *)[customersArray objectAtIndex:row];
  cell.textLabel.text = [customer name];
  cell.imageView.image = [customer photo];
	
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
	CustomerAddController *addController = [[CustomerAddController alloc] init];
  addController.customer = [customersArray objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:addController animated:YES];
  [addController release];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    Customer *customer = (Customer *)[self.customersArray objectAtIndex:indexPath.row];
    [customer setUploaded:[NSNumber numberWithInt:0]];
    [customer setDeleted:[NSNumber numberWithInt:1]];
    [customer save];
    
    [self.customersArray removeObjectAtIndex:indexPath.row];
    
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
  }   
  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }   
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void) customerAddController:(CustomerAddController *)customerAddController didAdd:(Customer *)customer {
  [[self customersArray] addObject:customer];
  //close add customer controller
  [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
	[customersArray release];
	[addButton release];
  [super dealloc];
}


@end

