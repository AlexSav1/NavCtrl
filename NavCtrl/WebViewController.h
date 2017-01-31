//
//  WebViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/31/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) NSString *urlString;

@end
