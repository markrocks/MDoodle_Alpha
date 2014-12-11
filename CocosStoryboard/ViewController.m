//
//  ViewController.m
//  Monster Doodle
//
//  Created by Mark Martin on 11/15/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import "ViewController.h"
//===================================
#define SPLASH_DELAY 3
#define SCREEN_FADE_RATE 1


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadSelectionView];
    [self registerEventListeners];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadSelectionView {
    self.selectionScreenViewController = [[SelectionScreenViewController alloc]initWithNibName:@"SelectionScreenViewController" bundle:nil];
    self.selectionScreenViewController.view.alpha = 0;
    self.selectionScreenViewController.view.frame = self.view.frame;
    
    [[self view] addSubview:self.selectionScreenViewController.view];
    [self.selectionScreenViewController didMoveToParentViewController:self];
    [[self view] bringSubviewToFront:self.selectionScreenViewController.view];
    
    // now animate selection screen into view
    [UIView animateWithDuration:SCREEN_FADE_RATE delay:SPLASH_DELAY options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.selectionScreenViewController.view.alpha = 1;
    } completion:nil];
    
}

-(void) loadDrawingView {
    
    self.drawingScreenViewController = [[DrawingScreenViewController alloc]initWithNibName:@"DrawingScreenViewController" bundle:nil];
    self.drawingScreenViewController.view.alpha = 0;
    self.drawingScreenViewController.view.frame = self.view.frame;
    
    [[self view] addSubview:self.drawingScreenViewController.view];
    [self.drawingScreenViewController didMoveToParentViewController:self];
    [[self view] bringSubviewToFront:self.drawingScreenViewController.view];
    
    //Now the Cocos2d drawing plane
    self.drawingPlaneController = [[SceneViewController alloc]initWithCoder:nil];
    self.drawingPlaneController.view.opaque= YES;
    self.drawingPlaneController.view.alpha = 0;
    self.drawingPlaneController.view.frame = self.view.frame;
    
    [[self view] addSubview:self.drawingPlaneController.view];
    [self.drawingPlaneController didMoveToParentViewController:self];
    [[self view] bringSubviewToFront:self.drawingPlaneController.view];

    
    // Now thee control overlay
    
    self.drawingControlsViewController = [[DrawingControlsViewController alloc]initWithNibName:@"DrawingControlsViewController" bundle:nil];
    self.drawingControlsViewController.view.alpha = 1;
    self.drawingControlsViewController.view.frame = self.drawingControlsViewController.uiBackground.frame;//CGRectMake(50, 50,300 ,300);
     
    [[self view] addSubview:self.drawingControlsViewController.view];
    [self.drawingControlsViewController didMoveToParentViewController:self];
    [[self view] bringSubviewToFront:self.drawingControlsViewController.view];

    
    
    
    
    // now animate selection screen into view
    [UIView animateWithDuration:SCREEN_FADE_RATE delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
     self.drawingScreenViewController.view.alpha = 1;
     //self.drawingControlsViewController.view.alpha = 1;
     self.drawingPlaneController.view.alpha = 1;
     } completion:nil];//^(BOOL finished){
    
    /*  self.drawingControlsViewController = [[DrawingControlsViewController alloc]initWithNibName:@"DrawingControlsViewController" bundle:nil];
     self.drawingControlsViewController.view.alpha = 0.5;
     self.drawingControlsViewController.view.frame = self.view.frame;
     
     [[self view] addSubview:self.drawingControlsViewController.view];
     [self.drawingControlsViewController didMoveToParentViewController:self];
     [[self view] bringSubviewToFront:self.drawingControlsViewController.view];
     
     //self.drawingControlsViewController.view.alpha = 1;
     self.drawingControlsViewController.view.backgroundColor = [UIColor clearColor];
     self.drawingControlsViewController.view.opaque = NO;
     */
    
    
    
    //self.drawingPlaneController.view.backgroundColor = [UIColor redColor];
    
    // }
    //];
}

-(void) registerEventListeners {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorPurple" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorBlue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorRed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"findNewMonster" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"getOldMonster" object:nil];
}

-(void)parseNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"colorPurple"]) {
        NSLog(@"purple clicked");
    }
    if ([[notification name] isEqualToString:@"colorBlue"]) {
        NSLog(@"blue clicked");
    }
    if ([[notification name] isEqualToString:@"colorRed"]) {
        NSLog(@"red clicked");
    }
    if ([[notification name] isEqualToString:@"findNewMonster"]) {
        NSLog(@"Find New");
    }
    if ([[notification name] isEqualToString:@"getOldMonster"]) {
        NSLog(@"get Old");
        [self loadDrawingView];
    }
}



@end
