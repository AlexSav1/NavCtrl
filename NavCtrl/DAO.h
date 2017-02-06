//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import <Foundation/Foundation.h>

@interface DAO : NSObject

@property (strong, nonatomic) NSMutableArray<Company*>* companies;

+ (id)sharedDataManager;

-(void) addCompanyName: (NSString*) companyName
              andImage: (NSString*) imgName;

@end
