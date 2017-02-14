//
//  WebViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/31/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Product.h"
#import "Company.h"

@class addProductViewController;

@interface WebViewController : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) NSString *urlString;

@property (nonatomic, retain) addProductViewController *addProductVC;

@property (nonatomic, retain) Product *selectedProduct;

@property (nonatomic, retain) Company *currentCompany;

@end
