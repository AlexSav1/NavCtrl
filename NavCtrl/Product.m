//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype) initWithName: (NSString*) productName
                       Image: (NSString*) imgName
                      andURL: (NSString*) urlString{
    
    self = [super init];
    if (self) {
        self.name = productName;
        self.imageName = imgName;
        self.url = urlString;
    }
    return self;
    
}


@end
