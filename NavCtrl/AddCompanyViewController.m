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
    
    self.dao = [DAO sharedDataManager];
    
    //self.title = @"Add Company";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
    
    self.navigationItem.rightBarButtonItem = saveButton;

    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    if([self.title  isEqual: @"Edit Company"]){
        self.companyNameTextField.text = self.selectedCompany.name;
        self.companyStockTextField.text = self.selectedCompany.stockTicker;
        self.companyPicTextField.text = self.selectedCompany.imageName;
    } else{
        self.companyNameTextField.text = @"";
        self.companyStockTextField.text = @"";
        self.companyPicTextField.text = @"";
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height/2;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) savePressed{
    
    if([self.title  isEqual: @"Add Company"]){
        [self.dao addCompanyName:self.companyNameTextField.text Ticker:self.companyStockTextField.text andImage:self.companyPicTextField.text];
    }
    
    if([self.title  isEqual: @"Edit Company"]){
        
        [self.dao editCompany:self.selectedCompany Name:self.companyNameTextField.text Ticker:self.companyStockTextField.text andImage:self.companyPicTextField.text];
    }
    
    
    
    
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
    
    [_selectedCompany release];
    
    [_companyNameTextField release];
    [_companyStockTextField release];
    [_companyPicTextField release];
    [super dealloc];
}
@end
