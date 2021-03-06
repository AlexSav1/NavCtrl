//
//  InitalCompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "InitalCompanyViewController.h"
#import "AddCompanyViewController.h"
#import "DAOProductViewController.h"
#import "addProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"


@interface InitalCompanyViewController ()

@end

@implementation InitalCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
       
    self.addCompanyViewController = [[AddCompanyViewController alloc] initWithNibName:@"AddCompanyViewController" bundle:nil];
    
    [self.addCompanyViewController view];
    
    self.daoProductViewController = [[DAOProductViewController alloc] initWithNibName:@"DAOProductViewController" bundle:nil];

    
    

    
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:(.498) green:(.706) blue:(.2235) alpha:1]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(.498) green:(.706) blue:(.2235) alpha:1]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //[self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    //self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"Companies";
    
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
    
    
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoPressed)];
    
    UIBarButtonItem *fixedSpace =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                  target:nil
                                                  action:nil];
    fixedSpace.width = 250;
    
    UIBarButtonItem *redoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(redoPressed)];
    
    NSArray *buttons = [NSArray arrayWithObjects: undoButton, fixedSpace, redoButton, nil];
    
    [self.toolBar setItems: buttons animated:YES];
    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editPressed)];
    
    self.navigationItem.leftBarButtonItem = editButton;
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.noConnection = TRUE;
    
    [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(getStockPrice) userInfo:nil repeats:YES];

    
   // NSLog(@"viewDidLoad getStockPrice");
   // [self getStockPrice];
    [fixedSpace release];
    [undoButton release];
    [addButton release];
}

-(void) getStockPrice{
    
    
    NSMutableString *currentStocks = [[NSMutableString alloc]init];
    
    for (Company *currCompany in self.dao.companies) {
        
        [currentStocks appendString: currCompany.stockTicker];
        
        if(currCompany != [self.dao.companies lastObject]){
            [currentStocks appendString:@"+"];
        }
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a", currentStocks];
    //NSLog(@"%@", urlString);
    [request setURL:[NSURL URLWithString:urlString]];
    
    request.HTTPMethod = @"GET";
    //request.HTTPBody = jsonData;
    //[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        
        if(httpResponse.statusCode == 200){
            
            //parse
            NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            //NSLog(@"%@", dataString);
            
            NSArray *components = [dataString componentsSeparatedByString:@"\n"];
            
            int i = 0;
            NSLog(@"Before dispatch");
            for (Company *currCompany in self.dao.companies) {
                currCompany.stockPrice = components[i];
                i ++;
            }
            [dataString release];
            [session release];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            NSLog(@"stockPrice updated");

            
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //self.outPutTextField.text = @"Failure";
                NSLog(@"Failure");
                if(self.noConnection == TRUE){
                    [self showOfflineAlert];
                    self.noConnection = FALSE;
                }
                
                
            });
            
        }

    }];
    [postDataTask resume];
    NSLog(@"stockPrice requested");
    
    
    //releasing
    [currentStocks release];
    [request release];
    
//    [urlString release];
//    [session release];
    
    
}

- (void)showOfflineAlert {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Info"
                                  message:@"You are offline"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)editPressed {
    if(![self.tableView isEditing]){
        [self.tableView setEditing:YES animated:YES];
        self.toolBar.hidden = NO;
        self.navigationItem.leftBarButtonItem.title = @"Done";
    } else {
        [self.tableView setEditing:NO animated:YES];
        self.toolBar.hidden = YES;
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    }
}

-(void) undoPressed{
    [self.dao undoManager];
    [self.tableView reloadData];
}

-(void) redoPressed{
    [self.dao redoManager];
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear getStockPrice");
    [self getStockPrice];
    
    if(self.dao.companies.count == 0){
        self.tableView.hidden = YES;
        self.noCompaniesView.hidden = NO;
    }
    else{
        self.tableView.hidden = NO;
        self.noCompaniesView.hidden = YES;
    }

    
    [self.tableView reloadData];
    NSLog(@"self.tableView reloadData");
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *company = [self.dao.companies objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", company.name, company.stockTicker]; //[self.companyList objectAtIndex:[indexPath row]];
    
    cell.detailTextLabel.text = company.stockPrice;
    
    cell.imageView.image = [UIImage imageNamed:company.imageName];
    
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    
    return cell;
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
     //NSLog(@"%li",(long)indexPath.row);
 return YES;
 }



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        //remove from array
        
        Company *currComp = [self.dao.companies objectAtIndex:indexPath.row];
        
        [self.dao removeCompany:currComp];
        
        
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
        //[currComp release];
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
        self.addCompanyViewController.selectedCompany = selectedCompany;
        
//        self.addCompanyViewController.companyNameTextField.text = selectedCompany.name;
//        self.addCompanyViewController.companyStockTextField.text = selectedCompany.stockTicker;
//        self.addCompanyViewController.companyPicTextField.text = selectedCompany.imageName;
        
        [self.navigationController
         pushViewController:self.addCompanyViewController
         animated:YES];

    } else{
        
        self.daoProductViewController.title = selectedCompany.name;
        
        self.daoProductViewController.currentCompany = selectedCompany;
        
        [self.navigationController
         pushViewController:self.daoProductViewController
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
    [_toolBar release];
    
    //VC's
    [_daoProductViewController release];
    [_addCompanyViewController release];
    [_addProductVC release];
    [_dao release];
    [super dealloc];
}
@end
