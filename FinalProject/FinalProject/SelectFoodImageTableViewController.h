//
//  SelectFoodImageTableViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-12.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFoodImageTableViewCell.h"

@protocol SelectFoodImageDelegate

-(void)imageDidSelect:(NSString*)foodImage;

@end

@interface SelectFoodImageTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *selectFoodImageTableView;

@property (weak,nonatomic) id<SelectFoodImageDelegate>selectFoodImageDelegate;
@property (strong, nonatomic) NSArray* foodImageArray;
@end
