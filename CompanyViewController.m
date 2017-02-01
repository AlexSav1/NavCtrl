//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"VIEW LOADED");
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dao = [DAO sharedDataManager];
       
//    //create products here too and initialize your companies with their associated products
//    Company *apple = [[Company alloc] initWithName:@"Apple" andImage:@"Apple-Logo"];
//    Company *samsung = [[Company alloc] initWithName:@"Samsung" andImage:@"samsung-logo.jpg"];
//    Company *lg = [[Company alloc] initWithName:@"LG" andImage:@"LG-Logo"];
//    Company *google = [[Company alloc] initWithName:@"Google" andImage:@"Google-Logo"];
//    
//    
//    
//    //apple products
//    Product *ipad = [[Product alloc] initWithName:@"iPad" Image:@"ipad" andURL:@"http://www.apple.com/ipad/"];
//    Product *ipodTouch = [[Product alloc] initWithName:@"iPod Touch" Image:@"ipod-touch" andURL:@"http://www.apple.com/ipod-touch/"];
//    Product *iphone = [[Product alloc] initWithName:@"iPhone" Image:@"iphone" andURL:@"http://www.apple.com/iphone/"];
//    
//    //samsung products
//    Product *s4 = [[Product alloc] initWithName:@"Galaxy S4" Image:@"galaxy-s4" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-s/samsung-galaxy-s4-verizon-white-frost-16gb-sch-i545zwavzw/"];
//    
//    Product *note = [[Product alloc] initWithName:@"Galaxy Note" Image:@"galaxy-note" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb"];
//    
//    Product *tab = [[Product alloc] initWithName:@"Galaxy Tab" Image:@"galaxy-tab" andURL:@"https://www.amazon.com/Samsung-Galaxy-Tablet-Black-SM-T580NZKAXAR/dp/B01EUC7NPI"];
//    
//    //lg products
//    Product *v20 = [[Product alloc] initWithName:@"V20" Image:@"v20" andURL:@"http://www.lg.com/us/mobile-phones/v20"];
//    Product *g5 = [[Product alloc] initWithName:@"G5" Image:@"g5" andURL:@"http://www.lg.com/us/mobile-phones/g5#G5Modularity"];
//    Product *stylo2 = [[Product alloc] initWithName:@"Stylo 2" Image:@"stylo-2" andURL:@"http://www.gsmarena.com/lg_stylo_2-8085.php"];
//    
//    //google products
//    Product *pixel = [[Product alloc] initWithName:@"Pixel" Image:@"pixel" andURL:@"https://madeby.google.com/phone/"];
//    Product *nexus = [[Product alloc] initWithName:@"Nexus" Image:@"nexus" andURL:@"https://www.google.com/nexus/"];
//    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" Image:@"pixel-c" andURL:@"https://store.google.com/product/pixel_c"];
//
//    
//    //Set inital arrays
//    
//    //add products to company arrays
//    apple.products = [[NSMutableArray alloc]initWithObjects:ipad, ipodTouch, iphone, nil];
//    samsung.products = [[NSMutableArray alloc]initWithObjects:s4, note, tab, nil];
//    lg.products = [[NSMutableArray alloc]initWithObjects:v20, g5, stylo2, nil];
//    google.products = [[NSMutableArray alloc]initWithObjects:pixel, nexus, pixelC, nil];

    
    //self.companyList = [[NSMutableArray alloc]initWithObjects:apple, samsung, lg, google, nil];
    
    //self.imageList = [[NSMutableArray alloc]initWithObjects:@"Apple-Logo", @"samsung-logo.jpg", @"LG-Logo", @"Google-Logo", nil];
    
    self.title = @"Mobile device makers";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //DAO *datamanager = [DAO sharedDataManager];
    //return datamanager.companies.count;
    //return [self.companyList count];
    
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



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //UITableViewCell *currCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    //NSLog(@"Cell lable title: %@", currCell.textLabel.text);

    Company *selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
    
    self.productViewController.title = selectedCompany.name;
    self.productViewController.currentCompany = selectedCompany;

    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}
 


@end
