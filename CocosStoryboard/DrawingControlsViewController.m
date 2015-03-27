//
//  DrawingControlsViewController.m
//  Monster Doodle
//
//  Created by Mark Martin on 11/19/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import "DrawingControlsViewController.h"

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

- (IBAction)saveButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"saveButton" object:self];
}

//
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color6" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.45 green:0.95 blue:0.5 alpha:.5]; //(0.45, 0.95, 0.5, 0.8)
}

- (IBAction)color7Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color7" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.95 blue:0.2 alpha:.5]; //(0.95, 0.95, 0.2, 0.8)
}

- (IBAction)color8Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color8" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.95 green:0.7 blue:0.2 alpha:.5]; //(0.95, 0.7, 0.2, 0.8)
}

- (IBAction)color9Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color9" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.5]; //(0.5, 0.5, 0.5, 0.8)
}

- (IBAction)color10Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color10" object:self];
    self.penImage.tintColor = [UIColor colorWithRed:.0 green:0.0 blue:0.0 alpha:.5]; //(0.0, 0.0, 0.0, 0.8)
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


//[[NSNotificationCenter defaultCenter]postNotificationName:@"markerSizeChanged" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:penSize] , @"penSize", nil] ];



//
//
//
/*
#pragma mark - Color message listeners
-(void) registerEventListeners {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorPurple" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorBlue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"colorRed" object:nil];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color4" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color5" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color6" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color7" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color8" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color9" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"color10" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"clearSlate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"eraserButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"markerPlusButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseNotification:) name:@"markerMinusButton" object:nil];
}

-(void)parseNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"colorPurple"]) {
        NSLog(@"purple clicked");
        penColor = ccc4f(0.8, 0.0, 0.8, 0.8);
    }
    if ([[notification name] isEqualToString:@"colorBlue"]) {
        NSLog(@"blue clicked");
        penColor = ccc4f(0.0, 0.0, 0.8, 0.8);
    }
    if ([[notification name] isEqualToString:@"colorRed"]) {
        NSLog(@"red clicked");
        penColor = ccc4f(0.8, 0.0, 0.0, 0.8);
    }
    //
    //
    if ([[notification name] isEqualToString:@"color1"]) {
        NSLog(@"color1 clicked");
        penColor = ccc4f(0.8, 0.0, 0.0, 0.8);
    }
    if ([[notification name] isEqualToString:@"color2"]) {
        NSLog(@"color\2 clicked");
        penColor = ccc4f(1.0, 0.0, 0.8, 0.8);
    }
    if ([[notification name] isEqualToString:@"color3"]) {
        NSLog(@"color3 clicked");
        penColor = ccc4f(0.5, 0.0, 1.0, 0.8);
    }
    if ([[notification name] isEqualToString:@"color4"]) {
        NSLog(@"color4 clicked");
        penColor = ccc4f(0.16, 0.75, 0.75, 0.8);
    }
    if ([[notification name] isEqualToString:@"color5"]) {
        NSLog(@"color5 clicked");
        penColor = ccc4f(0.1, 0.5, 0.2, 0.8);
    }
    if ([[notification name] isEqualToString:@"color6"]) {
        NSLog(@"color6 clicked");
        penColor = ccc4f(0.45, 0.95, 0.5, 0.8);
    }
    if ([[notification name] isEqualToString:@"color7"]) {
        NSLog(@"color7 clicked");
        penColor = ccc4f(0.95, 0.95, 0.2, 0.8);
    }
    if ([[notification name] isEqualToString:@"color8"]) {
        NSLog(@"color8 clicked");
        penColor = ccc4f(0.95, 0.7, 0.2, 0.8);
    }
    if ([[notification name] isEqualToString:@"color9"]) {
        NSLog(@"color9 clicked");
        penColor = ccc4f(0.5, 0.5, 0.5, 0.8);
    }
    if ([[notification name] isEqualToString:@"color10"]) {
        NSLog(@"color10 clicked");
        penColor = ccc4f(0.0, 0.0, 0.0, 0.8);
    }
    if ([[notification name] isEqualToString:@"eraserButton"]) {
        NSLog(@"eraserButton clicked");
        penColor = ccc4f(1.0, 1.0, 1.0, 0.5);
    }
    if ([[notification name] isEqualToString:@"clearSlate"]) {
        NSLog(@"CLEAR SLATE CALLED");
        [self clearSlate];
    }
    if ([[notification name] isEqualToString:@"markerPlusButton"]) {
        NSLog(@"markerPlusButton CALLED");
        [self increasePenSize];
    }
    if ([[notification name] isEqualToString:@"markerMinusButton"]) {
        NSLog(@"markerMinusButton CALLED");
        [self reducePenSize];
    }
}

*/
@end
