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

@property (nonatomic, strong) UIViewController *activeController;
@property (nonatomic) double timeVal ;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeVal =  SPLASH_DELAY;
    // Do any additional setup after loading the view, typically from a nib.
    [self loadViewWithViewController:@"SelectionScreenViewController" usingViewClass:[SelectionScreenViewController class]];
    //[self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[ImageLoaderCarouselViewController class]];
    [self registerEventListeners];
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 This method loads a passed in ViewController, instantiates it and displays it
 **/
-(void) loadViewWithViewController:(NSString *)controllerPropertyName usingViewClass:(Class )viewClass {
    
    //Manage memory by having only one ViewController at a time
    
   // NSTimeInterval *time =
    
    //First we create the new controller using the controller class argument that was passed in
    id viewController = [(UIViewController *)[[viewClass class] alloc ] initWithNibName:controllerPropertyName bundle:nil];
    
    //Now create a working refernce theat is a UIViewController so that we can perform some standard set up routines
    UIViewController *setupController = (UIViewController *) viewController;
    setupController.view.alpha = 0;
    setupController.view.frame = self.view.frame;
    
    [[self view] addSubview:setupController.view];
    [setupController didMoveToParentViewController:self];
    [[self view] bringSubviewToFront:setupController.view];
    
    // now animate selection screen into view
    [UIView animateWithDuration:SCREEN_FADE_RATE delay:self.timeVal options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        setupController.view.alpha = 1;
    } completion:^(BOOL finished) {
        //If a current 1 exists -- we remove it
        [self clearActiveView];
        // Now keep a reference to the controller so we can remove it if we add another one
        self.activeController = setupController;
    }];
    self.timeVal = 0;
}

-(void) clearActiveView {
    if ( self.activeController != nil)
    {
        [self.activeController removeFromParentViewController];
        [self.activeController willMoveToParentViewController:nil];
        [self.activeController.view removeFromSuperview];
        [self.activeController removeFromParentViewController];
        self.activeController = nil;
    }
    if ( self.drawingScreenViewController != nil)
    {
        [self.drawingScreenViewController removeFromParentViewController];
        [self.drawingScreenViewController willMoveToParentViewController:nil];
        [self.drawingScreenViewController.view removeFromSuperview];
        [self.drawingScreenViewController removeFromParentViewController];
        self.drawingScreenViewController = nil;
    }
    if ( self.drawingPlaneController != nil)
    {
        [self.drawingPlaneController.view setHidden:YES];
        /*
        [self.drawingPlaneController willMoveToParentViewController:nil];
        [self.drawingPlaneController.view removeFromSuperview];
        [self.drawingPlaneController removeFromParentViewController];
        self.drawingPlaneController = nil;
         */			
    }
    if ( self.drawingControlsViewController != nil)
    {
        [self.drawingControlsViewController removeFromParentViewController];
        [self.drawingControlsViewController willMoveToParentViewController:nil];
        [self.drawingControlsViewController.view removeFromSuperview];
        [self.drawingControlsViewController removeFromParentViewController];
        self.drawingControlsViewController = nil;
    }
}

/**
 This method loads the Drawing screen
 **/
-(void) loadDrawingView:(UIImage *) image {
    
    self.drawingScreenViewController = [[DrawingScreenViewController alloc]initWithNibName:@"DrawingScreenViewController" bundle:nil];
    self.drawingScreenViewController.view.alpha = 0;
    self.drawingScreenViewController.view.frame = self.view.frame;
    [self.drawingScreenViewController.monsterImage setImage:image];
    
    [[self view] addSubview:self.drawingScreenViewController.view];
    [self.drawingScreenViewController didMoveToParentViewController:self];
    
    [[self view] bringSubviewToFront:self.drawingScreenViewController.view];
    
    //Now the Cocos2d drawing plane
    if ( self.drawingPlaneController == nil)
    {
        self.drawingPlaneController = [[SceneViewController alloc]initWithCoder:nil];
        self.drawingPlaneController.view.opaque= YES;
        self.drawingPlaneController.view.alpha = 0;
        self.drawingPlaneController.view.frame = self.view.frame;
    
        [[self view] addSubview:self.drawingPlaneController.view];
        [self.drawingPlaneController didMoveToParentViewController:self];
        [[self view] bringSubviewToFront:self.drawingPlaneController.view];
    }
    else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clearSlate" object:self];
        [self.drawingPlaneController.view setHidden:NO];
        [[self view] bringSubviewToFront:self.drawingPlaneController.view];
        //TODO  Add Code to clear the drawing pane!
    }
    
    // Now the control overlay
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

/**
 Save the drawing layer ontop of the background iamge layer to 1 composite image. Files are saved in the Documents directory
 **/
-(void) saveDrawing {
    
    UIImage *bottomImage = self.drawingScreenViewController.monsterImage.image; //background image ////1st image
    UIImage *image       = [self.drawingPlaneController.introScene.lineDrawer.renderTexture  getUIImage]  ; //foreground image///2nd image
    
    CGSize newSize = CGSizeMake(1024, 768); // set your image rect
    UIGraphicsBeginImageContext( newSize );
    
    // Use existing opacity as is
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];///1st image set frame
    
    // Apply supplied opacity if applicable
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:1]; //2nd image set frame on bottom image with alpha value
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imgName = [self createSavedImageName];
    NSLog(@"imgName");
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imgName];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    [imageData writeToFile:savedImagePath atomically:NO];
}

- (NSString *) createSavedImageName {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy_MM_dd_hhmm"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    stringFromDate = [stringFromDate stringByAppendingString:@".png"];
    return stringFromDate;
}

-(void) registerEventListeners {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorPurple" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorBlue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorRed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"findNewMonster" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"getOldMonster" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"loadMenuScreen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"markerPlusButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"markerMinusButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"eraserButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"undoButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"loadDrawPaneWithImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"emailMonster" object:nil];

}

-(void)parseNotification:(NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    
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
        [self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[BundledCarouselViewController class]];
    }
    if ([[notification name] isEqualToString:@"emailMonster"]) {
        NSLog(@"Email Monster");
        [self loadViewWithViewController:@"EmailViewController" usingViewClass:[EmailViewController class]];
    }
    if ([[notification name] isEqualToString:@"getOldMonster"]) {
        NSLog(@"get Old");
        [self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[UserCarouselViewController class]];
    }
    if ([[notification name] isEqualToString:@"loadMenuScreen"]) {
        NSLog(@"loading selection screen");
        [self loadViewWithViewController:@"SelectionScreenViewController" usingViewClass:[SelectionScreenViewController class]];
    }
    if ([[notification name] isEqualToString:@"markerPlusButton"]) {
        NSLog(@"markerPlusButton clicked");
    }
    if ([[notification name] isEqualToString:@"markerMinusButton"]) {
        NSLog(@"markerMinusButton clicked");
    }
    if ([[notification name] isEqualToString:@"eraserButton"]) {
        NSLog(@"eraserButton clicked");
    }
    if ([[notification name] isEqualToString:@"undoButton"]) {
        NSLog(@"undoButton clicked");
        [self saveDrawing];
    }
    
    if ([[notification name] isEqualToString:@"loadDrawPaneWithImage"]) {
        NSLog(@"loadDrawPaneWithImage clicked");
        [self loadDrawingView:dict[@"image"]];
    }
}



@end



