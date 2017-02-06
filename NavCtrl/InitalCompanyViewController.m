//
//  InitalCompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "InitalCompanyViewController.h"
#import "AddCompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"


@interface InitalCompanyViewController ()

@end

@implementation InitalCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    self.title = @"Companies";
    
    self.dao = [DAO sharedDataManager];
    
    if(self.dao.companies.count == 0){
        self.tableView.hidden = YES;
        self.noCompaniesView.hidden = NO;
    }
    else{
        self.tableView.hidden = NO;
        self.noCompaniesView.hidden = YES;
    }
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompanyPressed)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed)];

    self.navigationItem.leftBarButtonItem = editButton;
}

- (void)editPressed {
    [self.tableView setEditing:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if(self.dao.companies.count == 0){
        self.tableView.hidden = YES;
        self.noCompaniesView.hidden = NO;
    }
    else{
        self.tableView.hidden = NO;
        self.noCompaniesView.hidden = YES;
    }

    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addCompanyPressed{
    
    AddCompanyViewController *addCompanyViewController =
    [[AddCompanyViewController alloc]
     initWithNibName:@"AddCompanyViewController" bundle:nil];
//
//    [self presentViewController:addCompanyViewController animated:YES completion:nil];
    
    [self.navigationController
     pushViewController:addCompanyViewController
     animated:YES];

    
    //Company *selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
    
    //self.productViewController.title = selectedCompany.name;
    //self.productViewController.currentCompany = selectedCompany;
    addCompanyViewController.dao = self.dao;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dao.companies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *company = [self.dao.companies objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = company.name; //[self.companyList objectAtIndex:[indexPath row]];
    
    cell.imageView.image = [UIImage imageNamed:company.imageName];
    
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    
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
        
        [self.dao.companies removeObjectAtIndex:indexPath.row];
        
        
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
    
    Company *selectedCompany = self.dao.companies[fromIndexPath.row];
    
    
    [self.dao.companies removeObjectAtIndex:fromIndexPath.row];
    [self.dao.companies insertObject: selectedCompany atIndex:toIndexPath.row];
    
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tableView release];
    [_noCompaniesView release];
    [super dealloc];
}
@end
