//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Product.h"
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataProperties.h"

@interface DAO : NSObject

@property (retain, nonatomic) NSMutableArray<Company*>* companies;
@property (retain, nonatomic) NSMutableArray *managedCompanies;

@property (strong) NSManagedObjectContext *managedObjectContext;

+ (id)sharedDataManager;
-(void)saveContext;

- (void)initializeCoreData;

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
           andImage: (NSString*) imgName
         forCompany: (Company*) currentCompany;


-(void) removeCompany: (Company*) selectedCompany;

-(void) removeProduct: (Product*) selectedProduct
           forCompany: (Company*) currentCompany;

-(void) undoManager;

-(void) redoManager;


@end
