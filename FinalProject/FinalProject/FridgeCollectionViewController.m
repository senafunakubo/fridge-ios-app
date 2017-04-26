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
    
    //For the logout button
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.34 green:0.66 blue:0.84 alpha:1.0];
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell cliced");
    Product * product = [self.productArray objectAtIndex:indexPath.row];
    self.amount = product.productAmount;
    self.clickedIndex = indexPath.row;
    [self modalOpen];
}

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

- (void)modalOpen{
    
    
    //create subview background
    self.modalBg =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,520)];
    self.modalBg.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:self.modalBg];
    
    //initialize UIView
    self.subView =[[UIView alloc] initWithFrame:CGRectMake(20,200,280,200)];
    self.subView.backgroundColor =  [UIColor colorWithWhite:1 alpha:1];
    
    
    [self.subView setAlpha:0.0];
    self.subView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    
    //animation
    [UIView beginAnimations:nil context:NULL];
    //0.4s
    [UIView setAnimationDuration:0.4];
    [self.subView setAlpha:1];
    
    self.subView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [self.modalBg addSubview:self.subView];
    [UIView commitAnimations];
    
    //label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 20, 280, 25);
    titleLabel.text = @"Click";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.238 green:0.501 blue:0.593 alpha:1.000];
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.subView addSubview:titleLabel];
    
    //show buttons
    self.buttons = [[NSMutableArray alloc]init];
    self.uiButtonX = 10;
    for(int index = 0; index < self.amount; index++)
    {
        [self didCreaatButton:index];
    }
    
    //close button
    UIButton* closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.frame = CGRectMake(0,150,280,25);
    closeBtn.layer.cornerRadius = 20;
    closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [closeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [self.subView addSubview:closeBtn];
    
    //click and close subview
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)changeAmount:(UIButton*)button{
    button.backgroundColor = [UIColor grayColor];
    [self.buttons removeObjectAtIndex: button.tag];
}

-(void)didCreaatButton:(NSInteger)index
{
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.tag = index;
    self.button.frame = CGRectMake(self.uiButtonX,55,40,40);
    self.button.layer.cornerRadius = 20;
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.button.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    self.button.backgroundColor = [UIColor blackColor];
    [self.button setTitle:[@(index+1) stringValue] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(changeAmount:) forControlEvents:UIControlEventTouchDown];
    [self.subView addSubview:self.button];
    self.uiButtonX += 50;
    
    [self.buttons addObject:self.button];
}

//close modal
- (void)close:(id)sender {
    Product * product = [self.productArray objectAtIndex:self.clickedIndex];
    product.productAmount = self.buttons.count;
    self.amount = self.buttons.count;
    [self.fridgeCollectionView reloadData];
    self.clickedIndex = 0;
    [self.modalBg removeFromSuperview];
}

//After clicking the logout button, the user will go back to login view.
-(void)btnOnClick:(id)sender
{
    //signs the user out of Firebase App
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    
    //signs the user out of Facebook App
    [FBSDKAccessToken setCurrentAccessToken:nil];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
