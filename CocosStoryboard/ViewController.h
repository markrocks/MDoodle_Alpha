//
//  ViewController.h
//  Monster Doodle
//
//  Created by Mark Martin on 11/15/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionScreenViewController.h"
#import "DrawingScreenViewController.h"
#import "DrawingControlsViewController.h"
#import "SceneViewController.h"
#import "ImageLoaderCarouselViewController.h"
#import "BundledCarouselViewController.h"
#import "UserCarouselViewController.h"
#import "EmailViewController.h"

@interface ViewController : UIViewController
@property (nonatomic,strong) SelectionScreenViewController *selectionScreenViewController;
@property (nonatomic,strong) DrawingScreenViewController *drawingScreenViewController;
@property (nonatomic,strong) DrawingControlsViewController *drawingControlsViewController;
@property (nonatomic,strong) SceneViewController *drawingPlaneController;

@end

