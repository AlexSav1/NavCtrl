//
//  Product.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *imageName;

@property (strong, nonatomic) NSString *url;

-(instancetype) initWithName: (NSString*) productName
                       Image: (NSString*) imgName
                      andURL: (NSString*) urlString;


@end
