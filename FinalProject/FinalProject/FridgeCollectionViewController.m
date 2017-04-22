//
//  FridgeCollectionViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-30.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "FridgeCollectionViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FridgeCollectionViewController ()

@end

@implementation FridgeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fridgeCollectionView.delegate = self;
    self.fridgeCollectionView.dataSource =self;
    
    self.productArray = [[NSMutableArray<Product*> alloc]init];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fridge"]];
    
    NSMutableArray<Product*>* fridgeItemsArray = [[NSMutableArray alloc]init];
    self.fridgeInCV = [[Fridge alloc]initWithFridgeItemsArray:fridgeItemsArray];
 
    UILongPressGestureRecognizer *lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:lpgr];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (void)viewDidAppear:(BOOL)animated
{
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
    foodImage.image = [UIImage imageNamed:product.productImageName];
    
    [foodImage.badgeView setBadgeValue:product.productAmount];
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
    [((MyTabBarViewController*)(self.tabBarController)) addFood:self.productArray];
}

//TODO
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell cliced");
    [self modalOpen];
}

////HeaderCollectionReusableView @implementation
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        //NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
//        //headerView.title.text = title;
//        //UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
//        //headerView.backgroundImage.image = headerImage;
//        
//        reusableview = headerView;
//    }
//    return reusableview;
//}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addProductViewSegue"])
    {
        ((AddProductViewController*)segue.destinationViewController).addProductDelegate = self;
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        // get the cell at indexPath (the one you long pressed)
        UICollectionViewCell* cell =
        [self.collectionView cellForItemAtIndexPath:indexPath];
        // do stuff with the cell
    }
    
}

- (void)modalOpen {
    //create subview background
    self.modalBg =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,720)];
    self.modalBg.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:self.modalBg];
    
    //initialize UIView
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(20,200,280,100)];
    view.backgroundColor =  [UIColor colorWithWhite:1 alpha:1];
    
    
    [view setAlpha:0.0];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    
    // アニメーション
    [UIView beginAnimations:nil context:NULL];
    // 秒数設定
    [UIView setAnimationDuration:0.4];
    [view setAlpha:1];
    
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [self.modalBg addSubview:view];
    [UIView commitAnimations];
    
    //label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 20, 280, 25);
    titleLabel.text = @"subview";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.238 green:0.501 blue:0.593 alpha:1.000];
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [view addSubview:titleLabel];
    
    //button
    UIButton* noButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    noButton.frame = CGRectMake(0,55,280,30);
    [noButton setTitle:@"Close" forState:UIControlStateNormal];
    
    noButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [noButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    noButton.tintColor = [UIColor colorWithRed:0.238 green:0.501 blue:0.593 alpha:1.000];
    
    //click and close subview
    [noButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:noButton];
    
}

- (void)close:(id)sender {
    //モーダルを閉じる
    [self.modalBg removeFromSuperview];
}

@end
