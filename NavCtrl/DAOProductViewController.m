//
//  DAOProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAOProductViewController.h"
#import "WebViewController.h"
#import "addProductViewController.h"
#import "Company.h"
#import "Product.h"


@interface DAOProductViewController ()

@end

@implementation DAOProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dao = [DAO sharedDataManager];
    
    if(self.currentCompany.products.count == 0){
        self.tableView.hidden = YES;
        self.noProductsView.hidden = NO;
    } else{
        self.tableView.hidden = NO;
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
        self.noProductsView.hidden = YES;
    }
    
    self.addProductVC = [[addProductViewController alloc] initWithNibName:@"addProductViewController" bundle:nil];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProductPressed)];
    
    self.navigationItem.rightBarButtonItem = addButton;


}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.companyNameLabel.text = self.currentCompany.name;
    
    self.companyImageView.image = [UIImage imageNamed:self.currentCompany.imageName];
    
    [self.tableView reloadData];
}

-(void) addProductPressed{
    
    //push to add/edit product view controller
    
    self.addProductVC.title = @"Add Product";
    
    self.addProductVC.currentCompany = self.currentCompany;
    
    [self.navigationController
     pushViewController:self.addProductVC
     animated:YES];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.currentCompany.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Product *currProduct = [self.currentCompany.products objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = currProduct.name;
    
    cell.imageView.image = [UIImage imageNamed:currProduct.imageName];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        //remove from array
        
        Product *currProd = [self.currentCompany.products objectAtIndex:indexPath.row];
        
        [self.dao removeProduct:currProd forCompany:self.currentCompany];
        
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        // Request table view to reload
        [tableView reloadData];
    }
    
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    
    
    Product *selectedProduct = [self.currentCompany.products objectAtIndex:fromIndexPath.row];
    
    [self.currentCompany.products removeObjectAtIndex:fromIndexPath.row];
    [self.currentCompany.products insertObject:selectedProduct atIndex:toIndexPath.row];
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    
    Product *selectedProduct = [self.currentCompany.products objectAtIndex:indexPath.row];
    
    
    self.webViewController = [[WebViewController alloc] init];
    
    self.webViewController.urlString = selectedProduct.url;
    
    self.webViewController.selectedProduct = selectedProduct;
    
    self.webViewController.currentCompany = self.currentCompany;

    self.webViewController.title = selectedProduct.name;
    
    
    // Push the view controller.
    [self.navigationController pushViewController:self.webViewController animated:YES];
}



- (void)dealloc {
    [_webViewController release];
    [_tableView release];
    [_noProductsView release];
    [_companyNameLabel release];
    [_companyImageView release];
    [super dealloc];
}
@end
