//
//  FridgeCollectionViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-30.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "FridgeCollectionViewController.h"

@interface FridgeCollectionViewController ()

@end

@implementation FridgeCollectionViewController
@synthesize fridgeCollectionView;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fridgeCollectionView.delegate = self;
    self.fridgeCollectionView.dataSource =self;
    
    self.productArray = [[NSMutableArray<Product*> alloc]init];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fridge"]];
    
    NSMutableArray<Product*>* fridgeItemsArray = [[NSMutableArray alloc]init];
    self.fridgeInCV = [[Fridge alloc]initWithFridgeItemsArray:fridgeItemsArray];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    //test
    [self.fridgeCollectionView reloadData];
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
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FridgeCollectionViewCell" forIndexPath:indexPath];

    Product * product = [self.productArray objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = product.productName;
    UIImageView * foodImage = (UIImageView *)[cell viewWithTag:2];
    foodImage.image = [UIImage imageNamed:@"apple"];
    
    [foodImage.badgeView setBadgeValue:10];
    [foodImage.badgeView setOutlineWidth:0.0];
    [foodImage.badgeView setPosition:MGBadgePositionBest];
    [foodImage.badgeView setBadgeColor:[UIColor blueColor]];

    return cell;
}

 //Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
}

-(void)productDidCreate:(Product *)product
{
    self.productArray = [self.fridgeInCV addFridge:product];
}

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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addProductViewSegue"])
    {
        ((AddProductViewController*)segue.destinationViewController).addProductDelegate = self;
    }
}

@end
