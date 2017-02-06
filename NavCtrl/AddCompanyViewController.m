//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"
#import "InitalCompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"


@interface AddCompanyViewController ()

@end

@implementation AddCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    self.title = @"Add Company";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
    
    self.navigationItem.rightBarButtonItem = saveButton;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) savePressed{
    
    
    [self.dao addCompanyName:self.companyNameTextField.text andImage:self.companyPicTextField.text];
    
    
    
    
//    InitalCompanyViewController *initalCompanyViewController =
//    [[InitalCompanyViewController alloc]
//     initWithNibName:@"InitalCompanyViewController" bundle:nil];
//    
    
    [self.navigationController
     popToRootViewControllerAnimated:YES];

    
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
    [_companyNameTextField release];
    [_companyStockTextField release];
    [_companyPicTextField release];
    [super dealloc];
}
@end
