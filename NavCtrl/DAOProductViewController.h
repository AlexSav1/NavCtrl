//
//  DAOProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DAO.h"

@class WebViewController;
@class addProductViewController;

@interface DAOProductViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) Company *currentCompany;

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) addProductViewController *addProductVC;

@property (retain, nonatomic) WebViewController *webViewController;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *noProductsView;

@property (retain, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *companyImageView;

@end
