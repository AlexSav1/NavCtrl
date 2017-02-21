//
//  Company.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import "Product.h"

@implementation Company

-(instancetype) initWithName: (NSString*) companyName
                      Ticker: (NSString*) stockName
                    andImage: (NSString*) imgName{
    
    self = [super init];
    if (self) {
        self.name = companyName;
        self.stockTicker = stockName;
        self.imageName = imgName;
    }
    return self;
   
}

-(void) dealloc{
    
    [_name release];
    [_stockTicker release];
    [_stockPrice release];
    [_imageName release];
    [_products release];
    
    [super dealloc];
}

@end
