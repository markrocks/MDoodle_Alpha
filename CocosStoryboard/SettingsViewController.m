//
//  SettingsViewController.m
//  MonsterDoodle
//
//  Created by Mark Martin on 5/3/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDefaults= [NSUserDefaults standardUserDefaults];
    int temp = [self.userDefaults integerForKey:@"defaultVolume"] ;
    [[self volumeSlider] setValue:((float)[self.userDefaults integerForKey:@"defaultVolume"] / 100)];
    [[self emailSwitch] setOn:([self.userDefaults integerForKey:@"emailInt"] == 1)];
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

- (IBAction)enableEmailAction:(id)sender {
    int emailInt =  [self emailSwitch].on ? 1 : 0;
    NSLog(@"email switch activated %i", emailInt);
    [self.userDefaults setInteger:emailInt forKey:@"emailInt"];
    [self.userDefaults synchronize];
}

- (IBAction)defaultVolumeAction:(id)sender {
    int defaultVolume = [[self volumeSlider] value] * 100;
    [self.userDefaults setInteger:defaultVolume forKey:@"defaultVolume"];
    NSLog(@"default volume slider activated-- value %d", defaultVolume);
    [self.userDefaults synchronize];
    int temp = [self.userDefaults integerForKey:@"defaultVolume"] ;
}

- (IBAction)homeButtonAction:(id)sender {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMenuScreen" object:self];
}
@end
