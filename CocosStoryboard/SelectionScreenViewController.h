//
//  SelectionScreenViewController.h
//  Monster Doodle
//
//  Created by Mark Martin on 11/17/14.
//  Copyright (c) 2014 Mark Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionScreenViewController : UIViewController
- (IBAction)findNewMonsterBtnAction:(id)sender;
- (IBAction)saveMonstereButtonAction:(id)sender;
- (IBAction)addMonsteroPhotoAction:(id)sender;
- (IBAction)openSettingsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addNewMonsterButton;
@property (weak, nonatomic) IBOutlet UIButton *loadSavedMonsterButton;

@end
