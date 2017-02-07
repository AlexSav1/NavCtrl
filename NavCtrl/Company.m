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

@end
