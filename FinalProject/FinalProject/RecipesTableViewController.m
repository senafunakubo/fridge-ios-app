//
//  RecipesTableViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-16.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "RecipesTableViewController.h"

@interface RecipesTableViewController ()

@end

@implementation RecipesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recipesTableView.delegate = self;
    self.recipesTableView.dataSource = self;
    
    self.recipeItems = [[NSMutableArray alloc]init];
    self.recipe = [[Recipe alloc]init];
    
    [self getJSON];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getJSON
{
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.edamam.com/search?q=chicken&app_id=74546fbb&app_key=072ca3c517204af6aa46935287f2ed60&from=0&to=10"];
    
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSLog(@"RESPONSE: %@",response);
                NSLog(@"DATA: %@",data);
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        NSArray *item = [[jsonResponse objectForKey:@"hits"]valueForKey:@"recipe"];
                        
                        self.objLabel = [item valueForKey:@"label"];
                        self.objImageUrl = [item valueForKey:@"image"];
                        self.objUrlShareAs = [item valueForKey:@"shareAs"];
                        
                        [self.tableView reloadData];

                        if (jsonError) {
                            // Error Parsing JSON
                            
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                            NSLog(@"%@",jsonResponse);
                        }
                    }  else {
                        //Web server is returning an error
                    }
                } else {
                    // Fail
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objLabel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecipesTableViewCell"];
    
    if(!cell)
    {
        cell = [[RecipesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecipesTableViewCell"];
    }
    self.recipe.recipeLabel = self.objLabel[indexPath.row];
    self.recipe.recipeImageUrl = self.objImageUrl[indexPath.row];
    self.recipe.recipeUrl = self.objUrlShareAs[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:self.recipe.recipeImageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    cell.recipeImage.image = [UIImage imageWithData:data];
    cell.recipeLabel.text = self.recipe.recipeLabel;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RecipeWebViewController* webView = (RecipeWebViewController*)[storyboard instantiateViewControllerWithIdentifier:@"RecipeWebViewID"];
    
    webView.recipeWebViewDelegate = self;
    
    self.clickedUrl = self.objUrlShareAs[indexPath.row];
    //self.recipe.recipeUrl[indexPath.row];
    [self.navigationController pushViewController:webView animated:YES];

    
}

-(NSString*)url
{
    return self.clickedUrl;
}

@end
