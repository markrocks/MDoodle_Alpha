//
//  IntroScene.h
//  CocosStoryboard
//
//  Created by Dimitri Giani on 29/07/14.
//  Copyright Dimitri Giani 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "LineDrawer.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene

// -----------------------------------------------------------------------

+ (IntroScene *)scene;
- (id)init;
@property (nonatomic, strong) UIView *cocosView;
@property (nonatomic, strong) UIImageView *background;


// -----------------------------------------------------------------------
@end