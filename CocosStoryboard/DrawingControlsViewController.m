
//
//  DrawingControlsViewController.m
//  Monster Doodle
//
//  Created by Mark Martin on 11/19/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import "DrawingControlsViewController.h"
#import "KLCPopup.h"
#import "NibButton.h"

@interface DrawingControlsViewController ()

@end

@implementation DrawingControlsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.penImage.image = [self.penImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.penImage.tintColor = [UIColor colorWithRed:.8 green:0 blue:0 alpha:.5];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(markerSizeAdjust:) name:@"markerSizeChanged" object:nil];
    //
    
    NSNumber *penSize = [NSNumber numberWithFloat:3.0];//3.0;
    CGRect rect = self.penImage.frame;
    
    CGSize size = CGSizeMake(9, [penSize doubleValue]/48 * 138);
    rect.size = size;
    [self.penNibImage setFrame:rect];
    self.penNibImage.image = [self imageWithImage:[UIImage imageNamed:@"nib.png"] scaledToSize:size];
    [self.instructionLabel setHidden:YES];
    
//    [self displayInstructions:@"hello"];
    
}

- (void)displayInstructions: (NSNumber *) inte{
    int imgNumber = [inte intValue];
    NSString *message;
   
    NSArray *captionArray =[NSArray arrayWithObjects:@"Draw Eyes",
    @"Draw drool",
    @"Draw an embaressing haircut",
    @"Draw 2d head",
    @"Draw teeth",
    @"Draw evil moustash",
    @"Draw legs",
    @"Draw his brain",
    @"Draw feet",
    @"Draw tounge",
    @"Draw mouth",
    @"Draw nose spikes",
    @"What is he eating?",
    @"Draw spikes",
    @"Draw wings",
//       @"Draw giant claw",
    @"Draw claws",
    @"Draw mouth",
    @"Draw his body",
//    @"Draw ice breath",
    @"Draw arms",
    @"Draw wings",
    @"Draw crazy eyebrows",
    @"Draw back spikes",
    @"Draw his body",
    @"Draw fire breath",
    @"Draw an underwater monster",
    @"Draw creepy nose",
    @"What is chasing this monster?",
//    @"Draw a head",
    @"Draw a tail", nil ];
    
    
    [self.instructionLabel setHidden:NO];
    [self.instructionLabel setText:[captionArray objectAtIndex:imgNumber]];

    [UIView animateWithDuration:3.0
     delay:2.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^{[self.instructionLabel setAlpha:1];}
                     completion:
     ^(BOOL finished) {
         [UIView animateWithDuration:3.0 delay:5.0 options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{ [self.instructionLabel setAlpha:0]; }completion:^(BOOL finished) {}];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)redButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorRed" object:self];
}

- (IBAction)purpleButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorPurple" object:self];
}

- (IBAction)blueButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorBlue" object:self];
}
- (IBAction)homeButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMenuScreen" object:self];
}
- (IBAction)markerPlusButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"markerPlusButton" object:self];
}
- (IBAction)markerMinusButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"markerMinusButton" object:self];
}
- (IBAction)eraserButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"eraserButton" object:self];
}
- (IBAction)undoButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"undoButton" object:self];
}

- (IBAction)redoButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"redoButton" object:self];
}

- (IBAction)saveButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveButton" object:self];
}

- (IBAction)penButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"penButton" object:self];
    [self showButtonPressed:nil];
}

//Ï[self

//
//
- (IBAction)color1Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorRed" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color1" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.8 green:0 blue:0 alpha:.5];
}

- (IBAction)color2Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorPurple" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color2" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:1 green:0 blue:.8 alpha:.5];
    
}

- (IBAction)color3Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorPurple" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color3" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.5 green:0 blue:1 alpha:.5];
}

- (IBAction)color4Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color4" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.16 green:0.75 blue:0.75 alpha:.5]; // 0.16, 0.75, 0.75, 0.8
}

- (IBAction)color5Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color5" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.1 green:0.5 blue:0.2 alpha:.5]; //(0.1, 0.5, 0.2, 0.8);
}

- (IBAction)color6Action:(id)sender {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"color6" object:self];
//    self.penImage.tintColor = [UIColor colorWithRed:.45 green:0.95 blue:0.5 alpha:.5]; //(0.45, 0.95, 0.5, 0.8)
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color6" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.95 blue:0.2 alpha:.5]; //(0.95, 0.95, 0.2, 0.8)
    //self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.7 blue:0.2 alpha:.5]; //(0.95, 0.7, 0.2, 0.8)
}

- (IBAction)color7Action:(id)sender {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"color7" object:self];
//    self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.95 blue:0.2 alpha:.5]; //(0.95, 0.95, 0.2, 0.8)
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color7" object:self];
    //self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.7 blue:0.2 alpha:.5]; //(0.95, 0.7, 0.2, 0.8)
    self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.7 blue:0.2 alpha:.5]; //(0.95, 0.7, 0.2, 0.8)
}

- (IBAction)color8Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color8" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.0 green:0.0 blue:0.0 alpha:.5]; //(0.0, 0.0, 0.0, 0.8)
}

- (IBAction)color9Action:(id)sender {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"color9" object:self];
//    self.penImage.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.5]; //(0.5, 0.5, 0.5, 0.8)
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color9" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.0 green:0.0 blue:1.0 alpha:.5]; //(0.0, 0.0, 0.0, 0.8)
    

}

- (IBAction)color10Action:(id)sender {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"color10" object:self];
//    self.penImage.tintColor = [UIColor colorWithRed:.0 green:0.0 blue:0.0 alpha:.5]; //(0.0, 0.0, 0.0, 0.8)
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color10" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.5]; //(0.5, 0.5, 0.5, 0.8)
}

- (void) markerSizeAdjust :(NSNotification *) notification
{
    NSNumber *penSize = [notification.userInfo objectForKey:@"penSize"] ;
    //326 × 231 // 231 - 48 = 183 //.2622 - nib ratio ( actual dimentions 237x138
    CGSize size = CGSizeMake(9, [penSize doubleValue]/48 * 138);
    
    CGRect rect = self.penImage.frame;
    rect.size = size;
    [self.penNibImage setFrame:rect];
    self.penNibImage.image = [self imageWithImage:[UIImage imageNamed:@"nib.png"] scaledToSize:size];
   /* [self.penImage setFrame:rect];
    self.penImage.image = [self imageWithImage:[UIImage imageNamed:@"Pen_icon.png"] scaledToSize:size];
    [self.penImageBase setFrame:rect];
    self.penImageBase.image = [self imageWithImage:[UIImage imageNamed:@"Pen_icon.png"] scaledToSize:size];
    */
    
    
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


//
//
//
- (void) setPenSize: (NibButton*) sender {
    NSNumber* pS = [NSNumber numberWithFloat:[sender.penSize floatValue] *.43];
    NSLog(@"pensize = %i", [pS intValue]);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"markerSizeSet" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                         pS , @"penSize", nil] ];
}



- (void)showButtonPressed:(id)sender {
    
    // Generate content view to present
    UIView* contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 12.0;
    [contentView setFrame:CGRectMake(0, 0, 557, 160)];
    
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"Brush_window_final2" ofType:@"png"];
    UIImage *prodImg = [[UIImage alloc] initWithContentsOfFile:thePath];
    //controller.productImg.image = prodImg;

    
    //UIImage *monsterImage = [[UIImage alloc]initWithContentsOfFile:@"Brush_window_final2"];
    UIImageView *monsterImageView =[[UIImageView alloc]initWithImage:prodImg];
    //monsterImageView.frame = contentView.bounds;
    //[contentView setFrame:CGRectMake(-278, -80, 557, 160)];
    [monsterImageView setCenter:CGPointMake(CGRectGetMidX([contentView bounds]), CGRectGetMidY([contentView bounds]))];
   
    NibButton* nibButton5 = [NibButton buttonWithType:UIButtonTypeCustom];
    nibButton5.backgroundColor = [UIColor clearColor];
    [nibButton5 setFrame:CGRectMake(30, 49, 62, 62)];
    nibButton5.penSize = [NSNumber numberWithInt:2];
    [nibButton5 addTarget:self action:@selector(setPenSize:)  forControlEvents:UIControlEventTouchUpInside ];
    
    NibButton* nibButton = [NibButton buttonWithType:UIButtonTypeCustom];
    nibButton.backgroundColor = [UIColor clearColor];
    [nibButton setFrame:CGRectMake(102, 47.5, 65, 65)];
    nibButton.penSize = [NSNumber numberWithInt:5];;
    [nibButton addTarget:self action:@selector(setPenSize:)  forControlEvents:UIControlEventTouchUpInside ];
    
    NibButton* nibButton1 = [NibButton buttonWithType:UIButtonTypeCustom];
    nibButton1.backgroundColor = [UIColor clearColor];
    [nibButton1 setFrame:CGRectMake(177, 45, 70, 70)];
    nibButton1.penSize = [NSNumber numberWithInt:10];
    [nibButton1 addTarget:self action:@selector(setPenSize:)  forControlEvents:UIControlEventTouchUpInside ];
    
    NibButton* nibButton2 = [NibButton buttonWithType:UIButtonTypeCustom];
    nibButton2.backgroundColor = [UIColor clearColor];
    [nibButton2 setFrame:CGRectMake(257, 40, 80, 80)];
    nibButton2.penSize = [NSNumber numberWithInt:20];
    [nibButton2 addTarget:self action:@selector(setPenSize:)  forControlEvents:UIControlEventTouchUpInside ];
    
    NibButton* nibButton3 = [NibButton buttonWithType:UIButtonTypeCustom];
    nibButton3.backgroundColor = [UIColor clearColor];
    [nibButton3 setFrame:CGRectMake(347, 35, 90, 90)];
    nibButton3.penSize = [NSNumber numberWithInt:30];
    [nibButton3 addTarget:self action:@selector(setPenSize:)  forControlEvents:UIControlEventTouchUpInside ];
    NibButton* nibButton4 = [NibButton buttonWithType:UIButtonTypeCustom];
    
    nibButton4.backgroundColor = [UIColor clearColor];
    [nibButton4 setFrame:CGRectMake(447, 30, 100, 100)];
    nibButton4.penSize = [NSNumber numberWithInt:40];
    [nibButton4 addTarget:self action:@selector(setPenSize:)  forControlEvents:UIControlEventTouchUpInside ];
    
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"markerPlusButton" object:self];
    

    //[dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //[contentView addSubview:dismissLabel];
    [contentView addSubview:monsterImageView];
    [contentView addSubview:nibButton5];
    [contentView addSubview:nibButton];
    [contentView addSubview:nibButton1];
    [contentView addSubview:nibButton2];
    [contentView addSubview:nibButton3];
    [contentView addSubview:nibButton4];
    
    //NSDictionary* views = NSDictionaryOfVariableBindings(contentView, nibButton1,  nibButton2);
    
    /*[contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentView]-(2)-[dismissLabel]-|"
                                             options:NSLayoutFormatAlignAllCenterX
                                             metrics:nil
                                               views:views]];*/
    /*[contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentView]-(<=1)-[nibButton2]"
                                             options:NSLayoutFormatAlignAllCenterX
                                             metrics:nil
                                               views:views]];//@"V:|-(100)-[nibButton2(40)]-|"
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentView]-(<=1)-[nibButton1]"
                                             options:NSLayoutFormatAlignAllCenterX
                                             metrics:nil
                                               views:views]];//@"V:|-(10)-[nibButton1(20)]-|" */
    
    /*[contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[dismissLabel]-(10)-|"
                                             options:0
                                             metrics:nil
                                               views:views]];*/
    /*[contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(40)-[nibButton1]-(60)-[nibButton2]-(40)-|"
                                             options:0
                                             metrics:nil
                                               views:views]];*/
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake((KLCPopupHorizontalLayout)3,
                                               (KLCPopupVerticalLayout)3);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:(KLCPopupShowType)2
                                         dismissType:(KLCPopupDismissType)3
                                            maskType:(KLCPopupMaskType)1
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:YES];
    
    
        [popup showWithLayout:layout];}


- (void)setNibSize:(NSInteger)size {
   
}



@end
