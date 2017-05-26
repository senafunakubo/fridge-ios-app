//
//  FavouriteViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-08.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "FavouriteViewController.h"

@interface FavouriteViewController ()

@end

@implementation FavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lastNumberOfproductArray = 0;
    //collectionView
    self.favouriteCollectionView.delegate = self;
    self.favouriteCollectionView.dataSource =self;
    
    self.productArray = [[NSMutableArray<Product*> alloc]init];
    self.favouriteArray = [[NSMutableArray<Product*> alloc]init];
    self.productArray = ((MyTabBarViewController*)(self.tabBarController)).productArray;
    //self.foodImageArray = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = @"Favourire List";
    
    NSMutableArray<Product*>* fridgeItemsArray = [[NSMutableArray alloc]init];
    self.fridgeInCV = [[Fridge alloc]initWithFridgeItemsArray:fridgeItemsArray];
    
    //tableView
    self.favouriteTableView.delegate = self;
    self.favouriteTableView.dataSource =self;
    
    //hide collectionview
    [self.favouriteTableView setHidden:YES];

}

- (void)viewDidAppear:(BOOL)animated
{
//    self.productArray = ((MyTabBarViewController*)(self.tabBarController)).productArray;
    if(!(self.lastNumberOfproductArray == ((MyTabBarViewController*)(self.tabBarController)).productArray.count))
    {
        [self addFavouriteArray:((MyTabBarViewController*)(self.tabBarController)).productArray];
        self.lastNumberOfproductArray = ((MyTabBarViewController*)(self.tabBarController)).productArray.count;
    }
    [self.favouriteCollectionView reloadData];
    [self.favouriteTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favouriteArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Product * product = [self.favouriteArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavouriteCollectionViewCell" forIndexPath:indexPath];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = product.productName;
    
    UIImageView * foodImage = (UIImageView *)[cell viewWithTag:2];
    if ([product.productImageName containsString:@"https"])
    {
        NSURL *url = [NSURL URLWithString:product.productImageName];
        NSData *data = [NSData dataWithContentsOfURL:url];
        foodImage.image = [UIImage imageWithData:data];
    }
    else if (product.productImage != nil)
    {
        foodImage.image = product.productImage;
    }
    else
    {
        foodImage.image = [UIImage imageNamed:product.productImageName];
    }
    return cell;
}

//TODO
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell clicked");
    self.clickedIndex = indexPath.row;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddProductViewController* viewController= (AddProductViewController*)[storyboard instantiateViewControllerWithIdentifier:@"addProductViewID"];
    
    viewController.addProductDelegate = self;
    
    
    
//    self.isEditProduct = 1;
//    [self.modalBg removeFromSuperview];
    [self.navigationController pushViewController:viewController animated:YES];

    
}

//TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favouriteArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavouriteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FavouriteTableViewCell"];
    
    if(!cell)
    {
        cell = [[FavouriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavouriteTableViewCell"];
    }
    Product * product = [self.favouriteArray objectAtIndex:indexPath.row];
    
    cell.foodNameLabel.text = product.productName;
    
    if ([product.productImageName containsString:@"https"])
    {
        NSURL *url = [NSURL URLWithString:product.productImageName];
        NSData *data = [NSData dataWithContentsOfURL:url];
        cell.foodImage.image = [UIImage imageWithData:data];
    }
    else if (product.productImage != nil)
    {
        cell.foodImage.image = product.productImage;
    }
    else
    {
        cell.foodImage.image = [UIImage imageNamed:product.productImageName];
    }
    
    //        NSDate *Today = [[NSDate alloc]init];
    //        NSComparisonResult result = [Today compare:product.productBestBefore];
    
    //        switch (result)
    //        {
    //            case NSOrderedSame:
    //                //  Till Today
    //             cell.fridgeWasteOrNot.image = [UIImage imageNamed:@"caution"];
    //                break;
    //
    //            case NSOrderedAscending:
    //                //  The food is fine.
    //             cell.fridgeWasteOrNot.image = [UIImage imageNamed:@"check"];
    //                break;
    //
    //            case NSOrderedDescending:
    //                //  The food is expired.
    //             cell.fridgeWasteOrNot.image = [UIImage imageNamed:@"cross"];
    //                break;
    //        }
    
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (IBAction)Swich:(id)sender {
    if([self.favouriteCollectionView isHidden])
    {
        [self.favouriteCollectionView setHidden:NO];
        [self.favouriteTableView setHidden:YES];
        
        [self.favouriteTableView reloadData];
    }
    else
    {
        [self.favouriteCollectionView setHidden:YES];
        [self.favouriteTableView setHidden:NO];
        
        [self.favouriteCollectionView reloadData];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addProductViewSegue"])
    {
        ((AddProductViewController*)segue.destinationViewController).addProductDelegate = self;
    }
}

-(void)addFavouriteArray:(NSMutableArray<Product*>*)productArray
{
    [((MyTabBarViewController*)(self.tabBarController)).productArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        Product * product = [((MyTabBarViewController*)(self.tabBarController)).productArray objectAtIndex:idx + self.lastNumberOfproductArray];

        if(product.isFavourite == YES)
        {
            [self.favouriteArray addObject:product];
        }
        if (idx + self.lastNumberOfproductArray == ((MyTabBarViewController*)(self.tabBarController)).productArray.count - 1) {
            // *stop=YES break
            *stop = YES;
        }
    }];
}

//delegate from addProductViewController
-(int)isEditProducts
{
    self.isEditFavouriteProduct = 1;
    return self.isEditFavouriteProduct;
}
-(Product*)getEditProduct
{
    Product* product = [self.favouriteArray objectAtIndex:self.clickedIndex];
    Product* productNew = [[Product alloc ]init];
    productNew.productName = product.productName;
    productNew.productImageName = product.productImageName;
    productNew.productType = product.productType;
    productNew.productPrice = product.productPrice;
    productNew.productAmount = product.productAmount;
    productNew.productBestBefore = product.productBestBefore;
    productNew.productMemo = product.productMemo;
    
    return productNew;
}
-(void)productDidCreate:(Product *)product
{
    self.productArray = [self.fridgeInCV addFridge:product];//necessary?
    [((MyTabBarViewController*)(self.tabBarController)) addFood:product];

}
-(void)isDoneEditProducts
{
    self.isEditFavouriteProduct = 0;
}
@end
