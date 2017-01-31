//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) NSMutableArray *imageList;

@property (nonatomic, retain) NSMutableArray *productsPersist;

@property (nonatomic, retain) NSMutableArray *imageListPersist;



@property (retain, nonatomic) WebViewController *webViewController;

@end
