//
//  Recipe.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-17.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

- (id)initWithRecipeLabel:(NSString*)recipeLabel recipeImageUrl:(NSString*)recipeImageUrl recipeUrl:(NSString*)
recipeUrl
{
    self= [super init];
    if(self)
    {
        self.recipeLabel = recipeLabel;
        self.recipeImageUrl = recipeImageUrl;
        self.recipeUrl = recipeUrl;
    }
    return self;
}

@end
