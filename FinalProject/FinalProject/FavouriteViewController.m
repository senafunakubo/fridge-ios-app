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
    
    UILongPressGestureRecognizer *lpgr
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.favouriteCollectionView addGestureRecognizer:lpgr];
    
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
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"cell cliced");
//    Product * product = [self.productArray objectAtIndex:indexPath.row];
//    self.amount = product.productAmount;
//    self.clickedIndex = indexPath.row;
//    [self modalOpen];
//}
//
//    NSLog(@"cell clicked");
//    self.clickedIndex = indexPath.row;
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    AddProductViewController* viewController= (AddProductViewController*)[storyboard instantiateViewControllerWithIdentifier:@"addProductTViewID"];
//    
//    viewController.addProductDelegate = self;
    
    
    
//    self.isEditProduct = 1;
//    [self.modalBg removeFromSuperview];
//    [self.navigationController pushViewController:viewController animated:YES];

    


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
        ((AddProductTableViewController*)segue.destinationViewController).addProductTVDelegate = self;
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
    if(self.isEditFavouriteProduct == 0)//if it is new data
    {
        [self.favouriteArray addObject:product];
    }
    else//if it is value changing
    {
        [self.favouriteArray replaceObjectAtIndex:self.clickedIndex withObject:product];
    }
}
-(void)isDoneEditProducts
{
    self.isEditFavouriteProduct = 0;
}

//Long press --> Edit and Deleate
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.favouriteCollectionView];
    
    NSIndexPath *indexPath = [self.favouriteCollectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        // get the cell at indexPath (the one you long pressed)
        UICollectionViewCell* cell =
        [self.favouriteCollectionView cellForItemAtIndexPath:indexPath];
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
    [self.favouriteArray removeObjectAtIndex:self.clickedIndex];
//    Product * product = [self.favouriteArray objectAtIndex:indexPath.row];
//    [((MyTabBarViewController*)(self.tabBarController)).productArray removeObjectAtIndex:self.clickedIndex];
    
    [self.favouriteCollectionView reloadData];
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
    
    self.isEditFavouriteProduct = 1;
    [self.modalBg removeFromSuperview];
    [self.navigationController pushViewController:viewController animated:YES];
    
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

@end
