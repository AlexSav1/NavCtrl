//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@class WebViewController;

@interface ProductViewController : UITableViewController


@property (nonatomic, retain) Company *currentCompany;

@property (retain, nonatomic) WebViewController *webViewController;


@end
