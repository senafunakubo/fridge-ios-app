//
//  RecipeWebViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-17.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeWebView.h"

@protocol RecipeWebViewDelegate

-(NSString*)url;

@end

@interface RecipeWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet RecipeWebView *recipeWebView;
@property (weak, nonatomic) id<RecipeWebViewDelegate> recipeWebViewDelegate;
@end
