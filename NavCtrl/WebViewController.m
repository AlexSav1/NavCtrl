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
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    
    
    webView.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editPressed)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    self.addProductVC = [[addProductViewController alloc] initWithNibName:@"addProductViewController" bundle:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) editPressed{
    
    self.addProductVC.title = @"Edit Product";
    
    self.addProductVC.selectedProduct = self.selectedProduct;
    
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

@end
