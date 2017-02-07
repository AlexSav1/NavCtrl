//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "Company.h"
#import "Product.h"

@implementation DAO

//ensures there could only be one DAO object
+ (id)sharedDataManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
        Company *apple = [[Company alloc] initWithName:@"Apple" Ticker:@"AAPL" andImage:@"Apple-Logo"];
        Company *samsung = [[Company alloc] initWithName:@"Samsung" Ticker:@"SSNLF" andImage:@"samsung-logo.jpg"];
        Company *lg = [[Company alloc] initWithName:@"LG" Ticker:@"LPL" andImage:@"LG-Logo"];
        Company *google = [[Company alloc] initWithName:@"Google" Ticker:@"GOOGL" andImage:@"Google-Logo"];
        
        
        
        //apple products
        Product *ipad = [[Product alloc] initWithName:@"iPad" Image:@"ipad" andURL:@"http://www.apple.com/ipad/"];
        Product *ipodTouch = [[Product alloc] initWithName:@"iPod Touch" Image:@"ipod-touch" andURL:@"http://www.apple.com/ipod-touch/"];
        Product *iphone = [[Product alloc] initWithName:@"iPhone" Image:@"iphone" andURL:@"http://www.apple.com/iphone/"];
        
        //samsung products
        Product *s4 = [[Product alloc] initWithName:@"Galaxy S4" Image:@"galaxy-s4" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-s/samsung-galaxy-s4-verizon-white-frost-16gb-sch-i545zwavzw/"];
        
        Product *note = [[Product alloc] initWithName:@"Galaxy Note" Image:@"galaxy-note" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb"];
        
        Product *tab = [[Product alloc] initWithName:@"Galaxy Tab" Image:@"galaxy-tab" andURL:@"https://www.amazon.com/Samsung-Galaxy-Tablet-Black-SM-T580NZKAXAR/dp/B01EUC7NPI"];
        
        //lg products
        Product *v20 = [[Product alloc] initWithName:@"V20" Image:@"v20" andURL:@"http://www.lg.com/us/mobile-phones/v20"];
        Product *g5 = [[Product alloc] initWithName:@"G5" Image:@"g5" andURL:@"http://www.lg.com/us/mobile-phones/g5#G5Modularity"];
        Product *stylo2 = [[Product alloc] initWithName:@"Stylo 2" Image:@"stylo-2" andURL:@"http://www.gsmarena.com/lg_stylo_2-8085.php"];
        
        //google products
        Product *pixel = [[Product alloc] initWithName:@"Pixel" Image:@"pixel" andURL:@"https://madeby.google.com/phone/"];
        Product *nexus = [[Product alloc] initWithName:@"Nexus" Image:@"nexus" andURL:@"https://www.google.com/nexus/"];
        Product *pixelC = [[Product alloc] initWithName:@"Pixel C" Image:@"pixel-c" andURL:@"https://store.google.com/product/pixel_c"];
        
        
        //Set inital arrays
        
        //add products to company arrays
        apple.products = [[NSMutableArray alloc]initWithObjects:ipad, ipodTouch, iphone, nil];
        samsung.products = [[NSMutableArray alloc]initWithObjects:s4, note, tab, nil];
        lg.products = [[NSMutableArray alloc]initWithObjects:v20, g5, stylo2, nil];
        google.products = [[NSMutableArray alloc]initWithObjects:pixel, nexus, pixelC, nil];
        
        self.companies = [[NSMutableArray alloc]initWithObjects:apple, samsung, lg, google,nil];
        
       
    }
    return self;
}


-(void) addCompanyName: (NSString*) companyName
                Ticker: (NSString*) stockName
              andImage: (NSString*) imgName{
    
    Company *newCompany = [[Company alloc] initWithName:companyName Ticker:stockName andImage:imgName];
    
    [self.companies addObject:newCompany];
    
}

-(void) editCompany: (NSInteger) selectedCompanyRow
               Name: (NSString*) companyName
             Ticker: (NSString*) stockName
           andImage: (NSString*) imgName{
    
   Company *selectedCompany = [self.companies objectAtIndex:(long)selectedCompanyRow];
    
    selectedCompany.name = companyName;
    selectedCompany.stockTicker = stockName;
    selectedCompany.imageName = imgName;
    
}

@end
