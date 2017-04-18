//
//  RecipesTableViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-16.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipesTableViewCell.h"
#import "Recipe.h"
#import "RecipeWebViewController.h"
#import "RecipeWebView.h"
#import "MyTabBarViewController.h"
#import "Product.h"

@interface RecipesTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,RecipeWebViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *recipesTableView;
@property (strong,nonatomic) Recipe * recipe;
@property (strong,nonatomic) NSArray * objLabel;
@property (strong,nonatomic) NSArray * objImageUrl;
@property (strong,nonatomic) NSArray * objUrlShareAs;
@property (strong, nonatomic) NSString * clickedUrl;
@property (strong, nonatomic) NSMutableArray<Product*>* productArray;

- (void)getJSON:(NSString*)productNameStr;

@end
