//
//  IntroScene.m
//  CocosStoryboard
//
//  Created by Dimitri Giani on 29/07/14.
//  Copyright Dimitri Giani 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"


// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    /*
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Helloworld scene button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.35f);
    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:helloWorldButton];
    */
    //
    //
    //
    //
    // Create a colored background (Dark Grey)
    //FIXME TODO -- adding the following 2 lines causes the drawing to invert on the vertical axis W T F???!!!
    //CCNodeColor *background2 = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    //[self addChild:background2];
    
    // TODO confirm -- added code based on http://forum.cocos2d-swift.org/t/cocos2d-swift-v3-can-not-set-glview-transparent/14968
        //self.colorRGBA = [self.color colorWithAlphaComponent:0.0];
    //
    //self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Monster_p08.png"]];
    //CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f]];
        //CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.0f]];
        //[self addChild:background];
    
    self.lineDrawer = [[LineDrawer alloc] init];
    self.lineDrawer.contentSize = [CCDirector sharedDirector].viewSize;
    self.lineDrawer.position = CGPointZero;
    self.lineDrawer.anchorPoint = CGPointZero;
    //lineDrawer
    [self addChild:self.lineDrawer];
    
   
    /*
    self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Monster_p08.png"]];
    //
    self.cocosView = [CCDirector sharedDirector].view;
    [self.cocosView setOpaque:NO];
    [self.cocosView.superview addSubview:self.background];
    [self.cocosView.superview sendSubviewToBack:self.background];
    
    lineDrawer.colorRGBA = [CCColor colorWithWhite:0 alpha:0];
     */
    //
    //
    // 
    //

    // done
	return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    // TODO confirm -- added code based on http://forum.cocos2d-swift.org/t/cocos2d-swift-v3-can-not-set-glview-transparent/14968
    self.colorRGBA = [self.color colorWithAlphaComponent:0.0];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
