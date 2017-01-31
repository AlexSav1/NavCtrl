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


@property (nonatomic, retain) NSMutableArray *productsPersist;

@property (nonatomic, retain) NSMutableArray *imageListPersist;


//Apple
@property (nonatomic, retain) NSMutableArray *appleProducts;

@property (nonatomic, retain) NSMutableArray *appleImageList;


//Samsung
@property (nonatomic, retain) NSMutableArray *samsungProducts;

@property (nonatomic, retain) NSMutableArray *samsungImageList;


//LG
@property (nonatomic, retain) NSMutableArray *lgProducts;

@property (nonatomic, retain) NSMutableArray *lgImageList;


//Google
@property (nonatomic, retain) NSMutableArray *googleProducts;

@property (nonatomic, retain) NSMutableArray *googleImageList;



@property (retain, nonatomic) WebViewController *webViewController;

@end
