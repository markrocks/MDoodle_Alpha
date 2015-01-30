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

//
//
//
- (IBAction)color1Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorRed" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color1" object:self];
}

- (IBAction)color2Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorPurple" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color2" object:self];
}

- (IBAction)color3Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"colorPurple" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color3" object:self];
}

- (IBAction)color4Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color4" object:self];
}

- (IBAction)color5Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color5" object:self];
}

- (IBAction)color6Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color6" object:self];
}

- (IBAction)color7Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color7" object:self];
}

- (IBAction)color8Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color8" object:self];
}

- (IBAction)color9Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color9" object:self];
}

- (IBAction)color10Action:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"color10" object:self];
}
@end
