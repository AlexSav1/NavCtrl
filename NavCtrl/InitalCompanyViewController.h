//
//  InitalCompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@class AddCompanyViewController;
@class DAOProductViewController;
@class addProductViewController;

@interface InitalCompanyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *noCompaniesView;

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) NSMutableArray *imageList;

@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic, retain)  AddCompanyViewController *addCompanyViewController;

@property (nonatomic, retain)  DAOProductViewController *daoProductViewController;

@property (nonatomic, retain) addProductViewController *addProductVC;

@end
