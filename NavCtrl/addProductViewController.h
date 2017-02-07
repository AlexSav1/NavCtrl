//
//  addProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"
#import "Product.h"

@class DAOProductViewController;

@interface addProductViewController : UIViewController

@property (nonatomic, retain) DAOProductViewController *daoProductViewController;

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) Company *currentCompany;

@property (nonatomic, retain) Product *selectedProduct;

@property (retain, nonatomic) IBOutlet UITextField *productNameTextField;

@property (retain, nonatomic) IBOutlet UITextField *productURLTextField;

@property (retain, nonatomic) IBOutlet UITextField *productImageURLTextField;

@end
