//
//  colorSwatchView.m
//  MonsterDoodle
//
//  Created by Mark Martin on 12/7/14.
//  Copyright (c) 2014 Sias Studios. All rights reserved.
//

#import "ColorSwatchView.h"

@interface ColorSwatchView()

@property(nonatomic) IBOutlet UIImageView *backgroundView;
@property(nonatomic) IBOutlet UIView *container;

@end

@implementation ColorSwatchView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//Add a custon element so I can use this in Interface Builder -- as noted in http://benedictcohen.co.uk/blog/archives/282


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    [self initalizeSubviews];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) return nil;
    [self initalizeSubviews];
    return self;
}

-(void)initalizeSubviews
{
    /*//Load the contents of the nib
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [nib instantiateWithOwner:self options:nil];
    //Add the view loaded from the nib into self.
    [self addSubview:self.container];
     */
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    
    //Just in case the size is different (you may or may not want this)
    mainView.frame = self.bounds;
    
    [self addSubview:mainView];
}




@end
