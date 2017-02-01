//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "WebViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

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

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    //Set inital arrays
    
    //Apple
        self.appleProducts = [[NSMutableArray alloc]initWithObjects:@"iPad", @"iPod Touch",@"iPhone", nil];
        self.appleImageList = [[NSMutableArray alloc]initWithObjects:@"ipad", @"ipod-touch", @"iphone", nil];
        
    //Samsung
        self.samsungProducts = [[NSMutableArray alloc]initWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
        self.samsungImageList = [[NSMutableArray alloc]initWithObjects:@"galaxy-s4", @"galaxy-note", @"galaxy-tab", nil];
    
    //LG
        self.lgProducts = [[NSMutableArray alloc]initWithObjects:@"V20", @"G5", @"Stylo 2", nil];
        self.lgImageList = [[NSMutableArray alloc]initWithObjects:@"v20", @"g5", @"stylo-2", nil];
    
    //Google
        self.googleProducts = [[NSMutableArray alloc]initWithObjects:@"Pixel", @"Nexus", @"Pixel C", nil];
        self.googleImageList = [[NSMutableArray alloc]initWithObjects:@"pixel", @"nexus", @"pixel-c", nil];
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]){
        self.productsPersist = self.appleProducts;
        self.imageListPersist = self.appleImageList;
    }
    else if ([self.title isEqualToString:@"Samsung mobile devices"]){
        self.productsPersist = self.samsungProducts;
        self.imageListPersist = self.samsungImageList;
    }
    else if ([self.title isEqualToString:@"LG mobile devices"]){
        self.productsPersist = self.lgProducts;
        self.imageListPersist = self.lgImageList;
    }
    else if ([self.title isEqualToString:@"Google mobile devices"]){
        self.productsPersist = self.googleProducts;
        self.imageListPersist = self.googleImageList;
    }
    
    [self.tableView reloadData];
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
    return [self.productsPersist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.productsPersist objectAtIndex:[indexPath row]];
    
    cell.imageView.image = [UIImage imageNamed:[self.imageListPersist objectAtIndex:[indexPath row]]];
    
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
        //[self.productsPersist removeObjectAtIndex:indexPath.row];
        //[self.imageListPersist removeObjectAtIndex:indexPath.row];
        
        if ([self.title isEqualToString:@"Apple mobile devices"]){
            [self.appleProducts removeObjectAtIndex:indexPath.row];
            [self.appleImageList removeObjectAtIndex:indexPath.row];
        }
        else if ([self.title isEqualToString:@"Samsung mobile devices"]){
            [self.samsungProducts removeObjectAtIndex:indexPath.row];
            [self.samsungImageList removeObjectAtIndex:indexPath.row];
        }
        else if ([self.title isEqualToString:@"LG mobile devices"]){
            [self.lgProducts removeObjectAtIndex:indexPath.row];
            [self.lgImageList removeObjectAtIndex:indexPath.row];
        }
        else if ([self.title isEqualToString:@"Google mobile devices"]){
            [self.googleProducts removeObjectAtIndex:indexPath.row];
            [self.googleImageList removeObjectAtIndex:indexPath.row];
        }

        
        
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
    
    
    //UITableViewCell *currCell = [self.tableView cellForRowAtIndexPath:fromIndexPath];
    
//    if ([self.title isEqualToString:@"Apple mobile devices"]){
//        
//    }
    
    NSString *stringToMove = self.productsPersist[fromIndexPath.row];
    NSString *imageToMove = self.imageListPersist[fromIndexPath.row];
    
    
    [self.productsPersist removeObjectAtIndex:fromIndexPath.row];
    [self.productsPersist insertObject:stringToMove atIndex:toIndexPath.row];
    
    [self.imageListPersist removeObjectAtIndex:fromIndexPath.row];
    [self.imageListPersist insertObject:imageToMove atIndex:toIndexPath.row];
    
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
    
    UITableViewCell *currCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    //NSLog(@"Cell lable title: %@", currCell.textLabel.text);

    
    self.webViewController = [[WebViewController alloc] init];
    
    
    // Pass the selected object to the new view controller.
    //Apple
        if ([currCell.textLabel.text  isEqual: @"iPad"]){
            self.webViewController.urlString = @"http://www.apple.com/ipad/";
        }
        else if ([currCell.textLabel.text  isEqual: @"iPod Touch"]){
            self.webViewController.urlString = @"http://www.apple.com/ipod-touch/";
        }
        else if ([currCell.textLabel.text  isEqual: @"iPhone"]){
            self.webViewController.urlString = @"http://www.apple.com/iphone/";
        }
    //Samsung
        else if ([currCell.textLabel.text  isEqual: @"Galaxy S4"]){
            self.webViewController.urlString = @"http://www.samsung.com/us/mobile/phones/galaxy-s/samsung-galaxy-s4-verizon-white-frost-16gb-sch-i545zwavzw/";
        }
        else if ([currCell.textLabel.text  isEqual: @"Galaxy Note"]){
            self.webViewController.urlString = @"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb";
        }
        else if ([currCell.textLabel.text  isEqual: @"Galaxy Tab"]){
            self.webViewController.urlString = @"https://www.amazon.com/Samsung-Galaxy-Tablet-Black-SM-T580NZKAXAR/dp/B01EUC7NPI";
        }
    //LG
        else if ([currCell.textLabel.text  isEqual: @"V20"]){
            self.webViewController.urlString = @"http://www.lg.com/us/mobile-phones/v20";
        }
        else if ([currCell.textLabel.text  isEqual: @"G5"]){
            self.webViewController.urlString = @"http://www.lg.com/us/mobile-phones/g5#G5Modularity";
        }
        else if ([currCell.textLabel.text  isEqual: @"Stylo 2"]){
            self.webViewController.urlString = @"http://www.gsmarena.com/lg_stylo_2-8085.php";
        }
    //Google
        else if ([currCell.textLabel.text  isEqual: @"Pixel"]){
            self.webViewController.urlString = @"https://madeby.google.com/phone/";
        }
        else if ([currCell.textLabel.text  isEqual: @"Nexus"]){
            self.webViewController.urlString = @"https://www.google.com/nexus/";
        }
        else if ([currCell.textLabel.text  isEqual: @"Pixel C"]){
            self.webViewController.urlString = @"https://store.google.com/product/pixel_c";
        }
    


    // Push the view controller.
    [self.navigationController pushViewController:self.webViewController animated:YES];
}
 


- (void)dealloc {
    [_webViewController release];
    [super dealloc];
}
@end
