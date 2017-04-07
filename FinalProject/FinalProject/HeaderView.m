//
//  HeaderView.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-03.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self ourInitializer];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self ourInitializer];
    }
    return self;
}

-(void) ourInitializer
{
    [[NSBundle mainBundle] loadNibNamed:@"Header" owner:self options:NULL];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    //self.contentView.backgroundColor = [UIColor lightGrayColor];
    //self.headerTitleLabel.text = @"Drink";
}



- (IBAction)sortFoodButton:(id)sender {
}

- (IBAction)addFoodButton:(id)sender {
}
@end
