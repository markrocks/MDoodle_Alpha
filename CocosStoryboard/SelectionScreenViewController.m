//
//  SelectionScreenViewController.m
//  Monster Doodle
//
//  Created by Mark Martin on 11/17/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import "SelectionScreenViewController.h"

@interface SelectionScreenViewController ()

@end

@implementation SelectionScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Load images
    //--- NEW BUTTON
    
    // -- create an array of img names
    NSArray *newImageNames = @[@"NewButtonv2_Cropped1.png", @"NewButtonv2_Cropped2.png", @"NewButtonv2_Cropped3.png", @"NewButtonv2_Cropped4.png"];
    //NSArray *savedImageNames = @[@"NewButtonv2_Cropped1.png", @"NewButtonv2_Cropped2.png", @"NewButtonv2_Cropped3.png", @"NewButtonv2_Cropped4.png"];
    
    // -- create an array of images by creating instances based on names in previous array
    NSMutableArray *newButtonImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < newImageNames.count; i++) {
        [newButtonImages addObject:[UIImage imageNamed:[newImageNames objectAtIndex:i]]];
    }
    
    // set the ImageView's animationImages object to the image array above
    self.addNewMonsterButton.imageView.animationImages = newButtonImages;
    
    //set the duration of the animation
    self.addNewMonsterButton.imageView.animationDuration = 1.5;
    
    //set the number of times to run
    self.addNewMonsterButton.imageView.animationRepeatCount = 1;
    
    //--- SAVED BUTTON
    
    
    // -- create an array of img names
   // NSArray *savedImageNames = @[@"NewButtonv2_Cropped1.png", @"NewButtonv2_Cropped2.png", @"wNewButtonv2_Cropped3.png", @"NewButtonv2_Cropped4"];
    NSArray *savedImageNames = @[@"SavedButtonv2_Cropped1.png", @"SavedButtonv2_Cropped1.png", @"SavedButtonv2_Cropped3.png", @"SavedButtonv2_Cropped4.png"];
    
    // -- create an array of images by creating instances based on names in previous array
    NSMutableArray *savedButtonImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < savedImageNames.count; i++) {
        [savedButtonImages addObject:[UIImage imageNamed:[savedImageNames objectAtIndex:i]]];
    }
    
    // set the ImageView's animationImages object to the image array above
    self.loadSavedMonsterButton.imageView.animationImages = savedButtonImages;
    
    //set the duration of the animation
    self.loadSavedMonsterButton.imageView.animationDuration = 2.5;
    
    //set the number of times to run
    self.loadSavedMonsterButton.imageView.animationRepeatCount = 1;

    
    ///[self.addNewMonsterButton startAnimating];
    

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

- (IBAction)findNewMonsterBtnAction:(id)sender {
    if (!self.addNewMonsterButton.imageView.isAnimating) {
        NSLog(@"new button anim started");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewMonsterInitialClick" object:self];
        [self.addNewMonsterButton.imageView startAnimating];
        [self.addNewMonsterButton.imageView setImage:[self.addNewMonsterButton.imageView.animationImages lastObject]];
        [self performSelector:@selector(newAnimationDidFinish) withObject:nil afterDelay:self.addNewMonsterButton.imageView.animationDuration];
    }
    
}

- (void)newAnimationDidFinish
{
    NSLog(@"new button anim ENDED");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewMonster" object:self];
}

- (IBAction)saveMonstereButtonAction:(id)sender {
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"getOldMonster" object:self];
    if (!self.loadSavedMonsterButton.imageView.isAnimating) {
        NSLog(@"load saved button anim started");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getOldMonsterInitialClick" object:self];
        [self.loadSavedMonsterButton.imageView startAnimating];
        [self.loadSavedMonsterButton.imageView setImage:[self.loadSavedMonsterButton.imageView.animationImages lastObject]];
        [self performSelector:@selector(loadSavedAnimationDidFinish) withObject:nil afterDelay:self.loadSavedMonsterButton.imageView.animationDuration];
    }
}

- (void)loadSavedAnimationDidFinish
{
    NSLog(@"lod save button anim ENDED");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getOldMonster" object:self];
}

- (IBAction)addMonsteroPhotoAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"emailMonster" object:self];
}

- (IBAction)openSettingsAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openSettings" object:self];
}
@end
