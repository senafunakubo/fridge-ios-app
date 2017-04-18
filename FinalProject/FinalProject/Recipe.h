//
//  Recipe.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-17.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (strong, nonatomic)NSString* recipeLabel;
@property (strong, nonatomic)NSString* recipeImageUrl;
@property (strong, nonatomic)NSString* recipeUrl;


- (id)initWithRecipeLabel:(NSString*)recipeLabel
           recipeImageUrl:(NSString*)recipeImageUrl
                recipeUrl:(NSString*)recipeUrl;
@end
