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
    [saveButton release];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if([self.title  isEqual: @"Edit Product"]){
        self.productNameTextField.text = self.selectedProduct.name;
        self.productURLTextField.text = self.selectedProduct.url;
        self.productImageURLTextField.text = self.selectedProduct.imageName;
    } else{
        self.productNameTextField.text = @"";
        self.productURLTextField.text = @"";
        self.productImageURLTextField.text = @"";
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
    
    if([self.title  isEqual: @"Add Product"]){
        [self.dao addProductForCompany:self.currentCompany Name:self.productNameTextField.text URL:self.productURLTextField.text andImage:self.productImageURLTextField.text];
    }
    
    if([self.title  isEqual: @"Edit Product"]){
        [self.dao editProduct:self.selectedProduct Name:self.productNameTextField.text URL:self.productURLTextField.text andImage:self.productImageURLTextField.text forCompany: self.currentCompany];
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
    
    [_daoProductViewController release];
    //[_dao release];
    [_currentCompany release];
    [_selectedProduct release];
    
    [_productNameTextField release];
    [_productURLTextField release];
    [_productImageURLTextField release];
    [super dealloc];
}
@end
