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
    
    //collectionView
    self.favouriteCollectionView.delegate = self;
    self.favouriteCollectionView.dataSource =self;
    
    self.productArray = [[NSMutableArray<Product*> alloc]init];
    //self.productArray = ((MyTabBarViewController*)(self.tabBarController)).productArray;
    self.foodImageArray = [[NSMutableArray alloc]init];
    
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
    [self.favouriteCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.productArray = ((MyTabBarViewController*)(self.tabBarController)).productArray;
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavouriteCollectionViewCell" forIndexPath:indexPath];
    
    Product * product = [self.productArray objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = product.productName;
//    UIImageView * foodImage = (UIImageView *)[cell viewWithTag:2];
//    foodImage.image = [UIImage imageNamed:@"apple"];
    return cell;
}

//-(void)productDidCreate:(Product *)product
//{
//    self.productArray = [self.fridgeInCV addFridge:product];
//}

//TODO
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell cliced");
}

//HeaderCollectionReusableView @implementation
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        //NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
        //headerView.title.text = title;
        //UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
        //headerView.backgroundImage.image = headerImage;
        
        reusableview = headerView;
    }
    return reusableview;
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([[segue identifier] isEqualToString:@"addProductViewSegue"])
//    {
//        ((AddProductViewController*)segue.destinationViewController).addProductDelegate = self;
//    }
//}

//TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productArray.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavouriteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FavouriteTableViewCell"];
    
    if(!cell)
    {
        cell = [[FavouriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavouriteTableViewCell"];
    }
    Product * product = [self.productArray objectAtIndex:indexPath.row];
    cell.foodNameLabel.text = product.productName;
    
//    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
//    nameLabel.text = product.productName;
//    UIImageView * foodImage = (UIImageView *)[cell viewWithTag:2];
//    foodImage.image = [UIImage imageNamed:self.foodImageArray[indexPath.row]];
    
    //NSDate *bestBeforeDate = product.productBestBefore;
    //cell.fridgeBestBefore.text = [NSString stringWithFormat:@"%@",[bestBeforeDate description]];
    
    
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
    return 100;
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

@end
