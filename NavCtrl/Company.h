//
//  Company.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *imageName;

@property (strong, nonatomic) NSMutableArray *products;

-(instancetype) initWithName: (NSString*) companyName
                    andImage: (NSString*) imgName;

@end
