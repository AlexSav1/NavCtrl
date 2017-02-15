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
        
          [self initializeCoreData];
        
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasRunAppOnceKey"] == NO){
            
            [self gettingStockCompanies];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasRunAppOnceKey"];
        
        } else{
            
            [self fetchFromCoreData];
            
        }
        
    }
    return self;
}

-(void)fetchFromCoreData {
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    [request setReturnsObjectsAsFaults:NO];
    
    NSError *error = nil;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    } else {
        
        self.managedCompanies = [[NSMutableArray alloc] initWithArray:results];
        
        self.companies = [[NSMutableArray alloc] init];
        
        for (ManagedCompany *currManComp in self.managedCompanies) {
            
            Company *currComp = [[Company alloc] initWithName:currManComp.name Ticker:currManComp.stockTicker andImage:currManComp.imageName];
            
            [self.companies addObject:currComp];
            NSLog(@"number of manProds: %lu", [currManComp.products count] );
            currComp.products = [[NSMutableArray alloc] init];
            
            for (ManagedProduct *currManProd in currManComp.products) {
                Product *currProd = [[Product alloc] initWithName:currManProd.name Image:currManProd.imageName andURL:currManProd.url];
                
                [currComp.products addObject:currProd];
            }
        }
    }

    
}


-(void) gettingStockCompanies{
    
    Company *apple = [[Company alloc] initWithName:@"Apple" Ticker:@"AAPL" andImage:@"Apple-Logo"];
    Company *samsung = [[Company alloc] initWithName:@"Samsung" Ticker:@"SSU.DE" andImage:@"samsung-logo.jpg"];
    Company *lg = [[Company alloc] initWithName:@"LG" Ticker:@"LGLG.F" andImage:@"LG-Logo"];
    Company *google = [[Company alloc] initWithName:@"Google" Ticker:@"GOOG" andImage:@"Google-Logo"];
    
    
    
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
    
    
    //using these companies.. make managed companies
    
    self.managedCompanies = [[NSMutableArray alloc] init];
    
    
    for (Company *currComp in self.companies) {
        ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
        mC.name = currComp.name;
        mC.stockTicker = currComp.stockTicker;
        mC.imageName = currComp.imageName;
        
        
        for (Product *currProd in currComp.products) {
            ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
            mP.name = currProd.name;
            mP.imageName = currProd.imageName;
            mP.url = currProd.url;
            [mP setCompany:mC];
            [mC.products setByAddingObject:mP];
        }
        NSLog(@"managed product count before saving: %lu", [mC.products count]);
        [self.managedCompanies addObject:mC];
    }
    
    
    
    //[self saveContext];

    
}

-(void)saveContext {
    
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (void)initializeCoreData{
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    moc.undoManager = [[NSUndoManager alloc]init];
    [moc setPersistentStoreCoordinator:psc];
    
    [self setManagedObjectContext:moc];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Model.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
    
}

-(void) addCompanyName: (NSString*) companyName
                Ticker: (NSString*) stockName
              andImage: (NSString*) imgName{
    
    Company *newCompany = [[Company alloc] initWithName:companyName Ticker:stockName andImage:imgName];
    
    [self.companies addObject:newCompany];
    
    ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
    mC.name = newCompany.name;
    mC.stockTicker = newCompany.stockTicker;
    mC.imageName = newCompany.imageName;

    [self.managedCompanies addObject:mC];
    
    //[self saveContext];
    
}

-(void) editCompany: (Company*) selectedCompany
               Name: (NSString*) companyName
             Ticker: (NSString*) stockName
           andImage: (NSString*) imgName{
    
   //Company *selectedCompany = [self.companies objectAtIndex:(long)selectedCompanyRow];
    
    selectedCompany.name = companyName;
    selectedCompany.stockTicker = stockName;
    selectedCompany.imageName = imgName;
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:selectedCompany]];

    
    mC.name = selectedCompany.name;
    mC.stockTicker = selectedCompany.stockTicker;
    mC.imageName = selectedCompany.imageName;
    
    //[self saveContext];
}



-(void) addProductForCompany: (Company*) currentCompany
                        Name: (NSString*) productName
                         URL: (NSString*) URLName
                    andImage: (NSString*) imgName{

    Product *newProduct = [[Product alloc] initWithName:productName Image:imgName andURL:URLName];
    
    [currentCompany.products addObject:newProduct];
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:currentCompany]];
    
    NSLog(@"currComp index: %lu", (unsigned long)[self.companies indexOfObject:currentCompany]);
    
    ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    
    mP.name = newProduct.name;
    mP.imageName = newProduct.imageName;
    mP.url = newProduct.url;
    
    [mP setCompany:mC];
    
    [mC.products setByAddingObject:mP];

    //[self saveContext];
}

-(void) editProduct: (Product*) currentProduct
               Name: (NSString*) productName
                URL: (NSString*) URLName
           andImage: (NSString*) imgName
         forCompany: (Company*) currentCompany{
    
    
    NSLog(@"currComp index: %lu", (unsigned long)[self.companies indexOfObject:currentCompany]);
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:currentCompany]];
    
    
    for (ManagedProduct *mP in mC.products) {
        
        if(currentProduct.name == mP.name){
            
            mP.name = productName;
            mP.imageName = imgName;
            mP.url = URLName;
            
        }
        
    }
    
    currentProduct.name = productName;
    currentProduct.url = URLName;
    currentProduct.imageName = imgName;

    
    //[self saveContext];
}

-(void) removeCompany: (Company*) selectedCompany{
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:selectedCompany]];
    [self.managedObjectContext deleteObject:mC];
    
    [self.managedCompanies removeObjectAtIndex:[self.companies indexOfObject:selectedCompany]];
    
    [self.companies removeObject:selectedCompany];
    
    //[self saveContext];
    
    

}

-(void) removeProduct: (Product*) selectedProduct
           forCompany: (Company*) currentCompany{
    
    [currentCompany.products removeObject:selectedProduct];
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:currentCompany]];
    
    ManagedProduct *currManProd;
    
    for (ManagedProduct *mP in mC.products) {
        
        if(selectedProduct.name == mP.name){
            currManProd = mP;
        }
        
    }
    
    [mC removeProductsObject:currManProd];

   //[self saveContext];
   
    
}

-(void) undoManager{
    
    [self.managedObjectContext.undoManager undo];
    
    [self fetchFromCoreData];
    
}

-(void) redoManager{
    
    [self.managedObjectContext.undoManager redo];
    
    [self fetchFromCoreData];

}

@end
