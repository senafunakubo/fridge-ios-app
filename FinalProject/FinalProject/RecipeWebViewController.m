//
//  RecipeWebViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-17.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "RecipeWebViewController.h"

@interface RecipeWebViewController ()

@end

@implementation RecipeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *urlString = [self.recipeWebViewDelegate url];
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.recipeWebView loadRequest:urlRequest];
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL
                          URLWithString:urlString];
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(270, 25, 0, 0)];
    shareButton.shareContent = content;
    [self.navigationController.navigationBar addSubview:shareButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
