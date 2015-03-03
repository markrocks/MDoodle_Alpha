//
//  DrawingControlsViewController.h
//  Monster Doodle
//
//  Created by Mark Martin on 11/19/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingControlsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *uiBackground;
- (IBAction)redButtonAction:(id)sender;
- (IBAction)purpleButtonAction:(id)sender;
- (IBAction)blueButtonAction:(id)sender;

- (IBAction)homeButtonAction:(id)sender;
- (IBAction)markerPlusButtonAction:(id)sender;
- (IBAction)markerMinusButtonAction:(id)sender;
- (IBAction)eraserButtonAction:(id)sender;
- (IBAction)undoButtonAction:(id)sender;



- (IBAction)color1Action:(id)sender;
- (IBAction)color2Action:(id)sender;
- (IBAction)color3Action:(id)sender;
- (IBAction)color4Action:(id)sender;
- (IBAction)color5Action:(id)sender;
- (IBAction)color6Action:(id)sender;
- (IBAction)color7Action:(id)sender;
- (IBAction)color8Action:(id)sender;
- (IBAction)color9Action:(id)sender;
- (IBAction)color10Action:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *penImage;

@end
