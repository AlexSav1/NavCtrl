//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) NSMutableArray *imageList;

@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;

@end
