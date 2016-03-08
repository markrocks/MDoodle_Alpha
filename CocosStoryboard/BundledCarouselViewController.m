//
//  BundledCarouselViewController.m
//  MonsterDoodle
//
//  Created by Mark Martin on 1/29/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "BundledCarouselViewController.h"

@interface BundledCarouselViewController ()

@end

@implementation BundledCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.deleteButton setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *) getImagePaths {
    NSArray *imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:@"Bundled Assets"];
    return imagePaths;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
