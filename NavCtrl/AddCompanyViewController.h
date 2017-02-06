//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/6/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

//@class InitalCompanyViewController;

@interface AddCompanyViewController : UIViewController

@property (nonatomic, retain) DAO *dao;

@property (retain, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyStockTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyPicTextField;

//@property (nonatomic, retain) IBOutlet  InitalCompanyViewController * initalCompanyViewController;

@end
