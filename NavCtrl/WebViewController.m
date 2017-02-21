//
//  WebViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/31/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "addProductViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    
    [theConfiguration release];
    self.webView.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editPressed)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    self.addProductVC = [[addProductViewController alloc] initWithNibName:@"addProductViewController" bundle:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = self.selectedProduct.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) editPressed{
    

    self.addProductVC.title = @"Edit Product";
    
    self.addProductVC.selectedProduct = self.selectedProduct;
    
    self.addProductVC.currentCompany = self.currentCompany;
    
    [self.navigationController
     pushViewController:self.addProductVC
     animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) dealloc{
    
    [_selectedProduct release];
    [_currentCompany release];
    [_webView release];
    [_addProductVC release];
    [_urlString release];
    [super dealloc];
}

@end
