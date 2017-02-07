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
    
    self.addCompanyViewController = [[AddCompanyViewController alloc]initWithNibName:@"AddCompanyViewController" bundle:nil];
    
    self.title = @"Companies";
    
    self.dao = [DAO sharedDataManager];
    
    if(self.dao.companies.count == 0){
        self.tableView.hidden = YES;
        self.noCompaniesView.hidden = NO;
    } else{
        self.tableView.hidden = NO;
        self.noCompaniesView.hidden = YES;
    }
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompanyPressed)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editPressed)];
    
    self.navigationItem.leftBarButtonItem = editButton;
    
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)editPressed {
    if(![self.tableView isEditing]){
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
    } else {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    }
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
    
//    AddCompanyViewController *addCompanyViewController =
//    [[AddCompanyViewController alloc]
//     initWithNibName:@"AddCompanyViewController" bundle:nil];
//
//    [self presentViewController:addCompanyViewController animated:YES completion:nil];
    
    [self.navigationController
     pushViewController:self.addCompanyViewController
     animated:YES];

    self.addCompanyViewController.title = @"Add Company";
    
    //Company *selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
    
    //self.productViewController.title = selectedCompany.name;
    //self.productViewController.currentCompany = selectedCompany;
    self.addCompanyViewController.dao = self.dao;
    
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


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
     NSLog(@"%li",(long)indexPath.row);
 return YES;
 }



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        //remove from array
        
        [self.dao.companies removeObjectAtIndex:indexPath.row];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if(self.dao.companies.count == 0){
            self.tableView.hidden = YES;
            self.noCompaniesView.hidden = NO;
            [self.tableView setEditing:NO animated:YES];
            self.navigationItem.leftBarButtonItem.title = @"Edit";
        }
        else{
            self.tableView.hidden = NO;
            self.noCompaniesView.hidden = YES;
        }

        
        // Request table view to reload
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        NSLog(@"%li",(long)indexPath.row);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    AddCompanyViewController *addCompanyViewController =
//    [[AddCompanyViewController alloc]
//     initWithNibName:@"AddCompanyViewController" bundle:nil];

    Company *selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
    
    if([self.tableView isEditing]){
        
        self.addCompanyViewController.title = @"Edit Company";
        self.addCompanyViewController.selectedCompanyRow = indexPath.row;
        
        self.addCompanyViewController.companyNameTextField.text = selectedCompany.name;
        self.addCompanyViewController.companyStockTextField.text = selectedCompany.stockTicker;
        self.addCompanyViewController.companyPicTextField.text = selectedCompany.imageName;
        
        [self.navigationController
         pushViewController:self.addCompanyViewController
         animated:YES];

    }
    
//    Company *selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
//    
//    self.productViewController.title = selectedCompany.name;
//    self.productViewController.currentCompany = selectedCompany;
//    
//    
//    [self.navigationController
//     pushViewController:self.productViewController
//     animated:YES];
    
    
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
