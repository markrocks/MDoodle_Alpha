//
//  SettingsViewController.h
//  MonsterDoodle
//
//  Created by Mark Martin on 5/3/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
- (IBAction)enableEmailAction:(id)sender;
- (IBAction)defaultVolumeAction:(id)sender;
- (IBAction)homeButtonAction:(id)sender;
@property NSUserDefaults *userDefaults;
@property (strong, nonatomic) IBOutlet UISwitch *emailSwitch;
@property (strong, nonatomic) IBOutlet UISlider *volumeSlider;

@property (strong, nonatomic) IBOutlet UILabel *emailPrefLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumePrefLabel;
@end
