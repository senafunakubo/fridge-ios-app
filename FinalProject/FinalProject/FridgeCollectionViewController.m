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
    
    //user is not logged in
    if([FIRAuth auth].currentUser.uid ==nil)
    {
        NSError *signOutError;
        [[FIRAuth auth] signOut:&signOutError];
    }
    else //user is logged in
    {
        NSLog(@"For logged out you need to click the button.");
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    self.isEditProduct = 0;
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
    return ((MyTabBarViewController*)(self.tabBarController)).productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FridgeCollectionViewCell" forIndexPath:indexPath];

    Product * product = [((MyTabBarViewController*)(self.tabBarController)).productArray objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = product.productName;
    UIImageView * foodImage = (UIImageView *)[cell viewWithTag:2];
    
    //if product.productImageName is URL
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
    
    NSInteger daysDifference = product.daysDifference;
    UILabel *daysLabel = (UILabel *)[cell viewWithTag:3];
    daysLabel.text = [NSString stringWithFormat:@"%ddays", daysDifference];
    
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

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    return CGSizeMake(60, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2; //the spacing between cells is 2 px here
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; //the spacing between cells is 0 px here
}

-(void)productDidCreate:(Product *)product
{
    if(self.isEditProduct == 0)//if it is new data
    {
        [self.fridgeInCV addFridge:product];
        [((MyTabBarViewController*)(self.tabBarController)) addFood:product];
    }
    else//if it is value changing
    {
        [((MyTabBarViewController*)(self.tabBarController)).productArray replaceObjectAtIndex:self.clickedIndex withObject:product];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell cliced");
    Product * product = [((MyTabBarViewController*)(self.tabBarController)).productArray objectAtIndex:indexPath.row];
    self.amount = product.productAmount;
    self.clickedIndex = indexPath.row;
    [self modalOpen];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addProductViewSegue"])
    {
        ((AddProductTableViewController*)segue.destinationViewController).addProductTVDelegate = self;
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
        self.clickedIndex = indexPath.row;
        [self modalOpenDelete];
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
    self.uiButtonX = 0;
    self.uiButtonY = 0;
    for(int index = 0; index < self.amount; index++)
    {
        [self didCreatButton:index];
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
    [closeBtn addTarget:self action:@selector(closeModal:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didCreatButton:(NSInteger)index
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.tag = index;
    self.button.frame = CGRectMake(self.uiButtonX+10,self.uiButtonY+55,40,40);

    [self.button setImage:[UIImage imageNamed:@"checkIcon"] forState:UIControlStateNormal];
    self.button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.button addTarget:self action:@selector(changeAmount:) forControlEvents:UIControlEventTouchDown];
    [self.subView addSubview:self.button];
    
    if(index == 4)
    {
        self.uiButtonX = 0;
        self.uiButtonY += 30;
    }
    else
    {
        self.uiButtonX += 50;
    }
    
    [self.buttons addObject:self.button];
}

-(void)changeAmount:(UIButton*)button{
    if([[button imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checkIcon"]])
    {
        [button setImage:[UIImage imageNamed:@"deletedIcon"] forState:UIControlStateNormal];
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"checkIcon"] forState:UIControlStateNormal];
    }
}

//close modal
- (void)closeModal:(id)sender {
    
    __block int count = 0;
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if([[obj imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checkIcon"]])
         {
             count++;
         }
     }];
    
    Product * product = [((MyTabBarViewController*)(self.tabBarController)).productArray objectAtIndex:self.clickedIndex];
    product.productAmount = count;
    self.amount = count;

    if(product.productAmount == 0)
    {
        [((MyTabBarViewController*)(self.tabBarController)).productArray removeObjectAtIndex:self.clickedIndex];
    }
    [self.fridgeCollectionView reloadData];
    self.clickedIndex = 0;
    [self.modalBg removeFromSuperview];
}

//long press modal open
- (void)modalOpenDelete{
    
    //create subview background
    self.modalBg =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,720)];
    self.modalBg.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:self.modalBg];
    
    //initialize UIView
    self.subView =[[UIView alloc] initWithFrame:CGRectMake(20,230,280,140)];
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
    titleLabel.text = @"Delete Food?";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.238 green:0.501 blue:0.593 alpha:1.000];
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.subView addSubview:titleLabel];
    
    //edit button
    UIButton* editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    editBtn.frame = CGRectMake(0,50,140,25);
    editBtn.layer.cornerRadius = 20;
    editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [editBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [self.subView addSubview:editBtn];
    
    //delete button
    UIButton* deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteBtn.frame = CGRectMake(140,50,140,30);
    deleteBtn.layer.cornerRadius = 20;
    deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [deleteBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [self.subView addSubview:deleteBtn];
    
    //cancel button
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0,100,280,30);
    cancelBtn.layer.cornerRadius = 20;
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.subView addSubview:cancelBtn];
    
    //click and close subview
    [deleteBtn addTarget:self action:@selector(deleteProduct:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn addTarget:self action:@selector(cancelModal:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn addTarget:self action:@selector(openAddProduct:) forControlEvents:UIControlEventTouchUpInside];
    
}

//delete button
- (void)deleteProduct:(id)sender {

    //delete object form the array
    [((MyTabBarViewController*)(self.tabBarController)).productArray removeObjectAtIndex:self.clickedIndex];

    [self.fridgeCollectionView reloadData];
    self.clickedIndex = 0;
    [self.modalBg removeFromSuperview];
}

//cancel modal
- (void)cancelModal:(id)sender {
    [self.modalBg removeFromSuperview];
}

//edit open
-(void)openAddProduct:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    AddProductTableViewController* viewController= (AddProductTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"addProductTViewID"];
    
    
    viewController.addProductTVDelegate = self;
    
    self.isEditProduct = 1;
    [self.modalBg removeFromSuperview];
    [self.navigationController pushViewController:viewController animated:YES];

}


-(int)isEditProducts
{
    return self.isEditProduct;
}
-(Product*)getEditProduct
{
        if(!(((MyTabBarViewController*)(self.tabBarController)).productArray.count == 0))
        {
//            self.productArray = ((MyTabBarViewController*)(self.tabBarController)).productArray;
            Product * product = [((MyTabBarViewController*)(self.tabBarController)).productArray objectAtIndex:self.clickedIndex];
            return product;
        }
        else
        {
            return nil;
        }
}
-(void)isDoneEditProducts
{
    self.isEditProduct = 0;
}

//After clicking the logout button, the user will go back to login or register view.
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
