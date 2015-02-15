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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewMonster" object:self];
}

- (IBAction)saveMonstereButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getOldMonster" object:self];
}

- (IBAction)addMonsteroPhotoAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"emailMonster" object:self];
}
@end
