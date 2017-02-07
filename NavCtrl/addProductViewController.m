//
//  addProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "addProductViewController.h"
#import "DAOProductViewController.h"

@interface addProductViewController ()

@end

@implementation addProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dao = [DAO sharedDataManager];
    
    self.daoProductViewController = [[DAOProductViewController alloc] initWithNibName:@"DAOProductViewController" bundle:nil];
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) savePressed{
    
    if([self.title  isEqual: @"Add Product"]){
        [self.dao addProductForCompany:self.currentCompany Name:self.productNameTextField.text URL:self.productURLTextField.text andImage:self.productImageURLTextField.text];
    }
    
    if([self.title  isEqual: @"Edit Product"]){
        
    }
    
    
//    [self.navigationController
//     popToViewController:self.daoProductViewController animated:YES];

    [self.navigationController popViewControllerAnimated:YES];
    
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
    [_productNameTextField release];
    [_productURLTextField release];
    [_productImageURLTextField release];
    [super dealloc];
}
@end
