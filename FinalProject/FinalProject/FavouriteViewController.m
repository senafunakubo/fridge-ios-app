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
    self.productArray = ((MyTabBarViewController*)(self.tabBarController)).productArray;
    if(!(self.lastNumberOfproductArray == self.productArray.count))
    {
        [self addFavouriteArray:self.productArray];
        self.lastNumberOfproductArray = self.productArray.count;
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
    else
    {
        foodImage.image = [UIImage imageNamed:product.productImageName];
    }
    return cell;
}

//TODO
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell cliced");
    
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
    [self.productArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        Product * product = [self.productArray objectAtIndex:idx + self.lastNumberOfproductArray];

        if(product.isFavourite == YES)
        {
            [self.favouriteArray addObject:product];
        }
        if (idx + self.lastNumberOfproductArray == self.productArray.count - 1) {
            // *stop=YES break
            *stop = YES;
        }
    }];
}

@end
