//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import <Foundation/Foundation.h>
#import "Product.h"

@interface DAO : NSObject

@property (strong, nonatomic) NSMutableArray<Company*>* companies;

+ (id)sharedDataManager;

-(void) addCompanyName: (NSString*) companyName
                Ticker: (NSString*) stockName
              andImage: (NSString*) imgName;

-(void) editCompany: (Company*) selectedCompany
               Name: (NSString*) companyName
             Ticker: (NSString*) stockName
           andImage: (NSString*) imgName;


-(void) addProductForCompany: (Company*) currentCompany
                        Name: (NSString*) productName
                         URL: (NSString*) URLName
                    andImage: (NSString*) imgName;

-(void) editProduct: (Product*) currentProduct
               Name: (NSString*) productName
                URL: (NSString*) URLName
           andImage: (NSString*) imgName;


@end
