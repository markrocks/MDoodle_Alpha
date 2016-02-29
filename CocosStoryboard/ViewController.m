//
//  ViewController.m
//  Monster Doodle
//
//  Created by Mark Martin on 11/15/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import "ViewController.h"
//===================================
#define SPLASH_DELAY 0//3
#define SCREEN_FADE_RATE 1
#define DRAWING_CONTROLS_WIDTH 147
#define DRAWING_CONTROLS_HEIGHT 767


@interface ViewController ()

@property (nonatomic, strong) UIViewController *activeController;
@property (nonatomic) double timeVal ;
@property (nonatomic) SystemSoundID pewPewSound;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeVal =  SPLASH_DELAY;
    // Do any additional setup after loading the view, typically from a nib.
    // if showSplash ( is true )
        //load splash and then load SelectionScreenViewController
    
    //TO DO -- add completion block passing to  loadViewWithViewController
    
    
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }


    
    
    [self loadViewWithViewController:@"SelectionScreenViewController" usingViewClass:[SelectionScreenViewController class]];
    //[self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[ImageLoaderCarouselViewController class]];
    [self registerEventListeners];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.view.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height);
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
     NSLog(@"controllerPropertyName = %@", controllerPropertyName );
    id viewController = [(UIViewController *)[[viewClass class] alloc ] initWithNibName:controllerPropertyName bundle:nil];
    
    //Now create a working refernce that is a UIViewController so that we can perform some standard set up routines
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
    if ( self.drawingScreenViewController != nil) // the view that contains the monster image
    {
        [self.drawingScreenViewController removeFromParentViewController];
        [self.drawingScreenViewController willMoveToParentViewController:nil];
        [self.drawingScreenViewController.view removeFromSuperview];
        [self.drawingScreenViewController removeFromParentViewController];
        self.drawingScreenViewController = nil;
    }
    if ( self.drawingPlaneController != nil)// The layer where the drawing takes place
    {
        [self.drawingPlaneController.view setHidden:YES];
        /*
        [self.drawingPlaneController willMoveToParentViewController:nil];
        [self.drawingPlaneController.view removeFromSuperview];
        [self.drawingPlaneController removeFromParentViewController];
        self.drawingPlaneController = nil;
         */			
    }
    if ( self.drawingControlsViewController != nil) // the button view
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
    
    self.drawingScreenViewController.view.frame = self.view.frame; // resize the monster image frame  to fit the device
    
    [self.drawingScreenViewController.monsterImage setImage:image];
    self.drawingScreenViewController.monsterImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [[self view] addSubview:self.drawingScreenViewController.view];
    [self.drawingScreenViewController didMoveToParentViewController:self];
    
    [[self view] bringSubviewToFront:self.drawingScreenViewController.view];
    
    //Now the Cocos2d drawing plane
    if ( self.drawingPlaneController == nil)
    {
        //self.drawingPlaneController = [[SceneViewController alloc]initWithCoder:nil];
        self.drawingPlaneController = [[SceneViewController alloc]init];
        self.drawingPlaneController.view.opaque= YES;
        self.drawingPlaneController.view.alpha = 0;
        self.drawingPlaneController.view.frame = self.view.frame;// resize the draw layer frame  to fit the device
        
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
    /**
    //Now the Cocos2d erasing plane
    if ( self.erasingPlaneController == nil)
    {
        self.erasingPlaneController = [[SceneViewController alloc]initWithCoder:nil];
        self.erasingPlaneController.view.opaque= YES;
        self.erasingPlaneController.view.alpha = 0;
        self.erasingPlaneController.view.frame = self.view.frame;
        
        [[self view] addSubview:self.erasingPlaneController.view];
        [self.erasingPlaneController didMoveToParentViewController:self];
        [[self view] bringSubviewToFront:self.erasingPlaneController.view];
    }
    else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"clearSlate" object:self];
        [self.erasingPlaneController.view setHidden:NO];
        [[self view] bringSubviewToFront:self.erasingPlaneController.view];    }
     **/
    
    // Now the control overlay
    self.drawingControlsViewController = [[DrawingControlsViewController alloc]initWithNibName:@"DrawingControlsViewController" bundle:nil];
    //self.drawingControlsViewController.view.alpha = 1;
    
    //self.drawingControlsViewController.view.frame = self.drawingControlsViewController.uiBackground.frame;//CGRectMake(50, 50,300 ,300); // THIS IS WHAT CAUSES ALL THE REDRAW WIERDNESS
    
    //The background is 147 x 767 -- we need to make sure the frame is the same aspect ratio
    self.drawingControlsViewController.view.frame = CGRectMake(0, 0,(self.view.frame.size.height / DRAWING_CONTROLS_HEIGHT )* DRAWING_CONTROLS_WIDTH ,self.view.frame.size.height);
    
     
    [[self view] addSubview:self.drawingControlsViewController.view];
    [self.drawingControlsViewController didMoveToParentViewController:self];
    [[self view] bringSubviewToFront:self.drawingControlsViewController.view];

    // now animate selection screen into view
    [UIView animateWithDuration:SCREEN_FADE_RATE delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
     self.drawingScreenViewController.view.alpha = 1;
     self.drawingControlsViewController.view.alpha = 1;
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
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width * [bottomImage scale],newSize.height * [bottomImage scale])];///1st image set frame
    
    // Apply supplied opacity if applicable
    
    [image drawInRect:CGRectMake(0,0,newSize.width * [image scale],newSize.height *[image scale]) blendMode:kCGBlendModeNormal alpha:1]; //2nd image set frame on bottom image with alpha value
    
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


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

-(void) findNewMonster {
    //[self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[BundledCarouselViewController class]];
    //[self loadViewWithViewController:@"TrickCollectionViewController" usingViewClass:[TrickCollectionViewController class]];
    [self buttonPressedWithSound];
    
    [self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[BundledCarouselViewController class]];
    
    /**
    //
    //
    void (^animationBlock)() = ^{
        NSArray *rainbowColors = @[[UIColor orangeColor],
                                   [UIColor yellowColor],
                                   [UIColor greenColor],
                                   [UIColor blueColor],
                                   [UIColor purpleColor],
                                   [UIColor redColor]];
        
        NSUInteger colorCount = [rainbowColors count];
        for(NSUInteger i=0; i<colorCount; i++) {
            [UIView addKeyframeWithRelativeStartTime:i/(CGFloat)colorCount
                                    relativeDuration:1/(CGFloat)colorCount
                                          animations:^{
                                              self.activeController.view.backgroundColor = rainbowColors[i];
                                          }];
        }
    };
    //----------
    [UIView animateKeyframesWithDuration:4.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear |
     UIViewAnimationOptionCurveLinear
                              animations:animationBlock
                              completion:^(BOOL finished) {
                                  //[self enableToolbarItems:YES];
                                  [self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[BundledCarouselViewController class]];
                              }];
    //
    //
     **/
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"saveButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"penButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"loadDrawPaneWithImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"emailMonster" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"openSettings" object:nil];

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
        [self findNewMonster];
    }
    if ([[notification name] isEqualToString:@"openSettings"]) {
        NSLog(@"Open Settings");
        [self loadViewWithViewController:@"SettingsViewController" usingViewClass:[SettingsViewController class]];
    }
    if ([[notification name] isEqualToString:@"emailMonster"]) {
        NSLog(@"Email Monster");
        [self loadViewWithViewController:@"EmailViewController" usingViewClass:[EmailViewController class]];
    }
    if ([[notification name] isEqualToString:@"getOldMonster"]) {
        NSLog(@"get Old");
        [self loadViewWithViewController:@"ImageLoaderCarouselViewController" usingViewClass:[UserCarouselViewController class]];
        [self buttonPressedWithSound];
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
    if ([[notification name] isEqualToString:@"saveButton"]) {
        NSLog(@"saveButton clicked");
        [self saveDrawing];
    }
    if ([[notification name] isEqualToString:@"penButton"]) {
        NSLog(@"penButton clicked");
    }
    
    if ([[notification name] isEqualToString:@"loadDrawPaneWithImage"]) {
        NSLog(@"loadDrawPaneWithImage clicked");
        [self loadDrawingView:dict[@"image"]];
    }
}

-(void)buttonPressedWithSound {
    
    int randomSoundNumber = arc4random() % 4; //random number from 0 to 3
    
    NSLog(@"random sound number = %i", randomSoundNumber);
    
    //NSString *monsterSoundFile;
    /**
    switch (randomSoundNumber) {
        case 0:
            monsterSoundFile = @"MONSTERBite1.mp3";
            break;
        case 1:
            monsterSoundFile = @"MONSTERBite2.mp3";
            break;
        case 2:
            monsterSoundFile = @"MONSTERBite3.mp3";
            break;
        case 3:
            monsterSoundFile = @"MONSTERBite4.mp3";
            break;
            
        default:
            break;
    }
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:monsterSoundFile ofType:nil inDirectory:@"Bundled Assets"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((CFURLRef)CFBridgingRetain(soundUrl), &soundID);
    AudioServicesPlaySystemSound(soundID);

**/
}




@end



