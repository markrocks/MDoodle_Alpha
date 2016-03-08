//
//  UserCarouselViewController.m
//  MonsterDoodle
//
//  Created by Mark Martin on 1/29/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "UserCarouselViewController.h"

@interface UserCarouselViewController ()

@end

@implementation UserCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.deleteButton setHidden:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *) getImagePaths {
    //NSArray *imagePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //return imagePaths;
//TODO  use  URLsForDirectory:inDomains: instead
    
    
    /*
     TODO - determine why one would use a bundle ID for a URL
     
     // If a valid app support directory exists, add the
     // app's bundle ID to it to specify the final directory.
     if (appSupportDir) {
     NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
     appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
     }
     */
    
    NSURL *appDataDir = nil;
    NSArray *imagePaths = nil;
    
    // Create the NS File Manager
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    NSArray *possibleDirectories = [sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    if ([possibleDirectories count] >= 1)
    {
        // Use the first directory (if multiple are returned)
        appDataDir = [possibleDirectories objectAtIndex:0];
        NSError *error = nil;
        NSArray *properties = [NSArray arrayWithObjects: NSURLLocalizedNameKey,
                               NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey, nil];
        
        imagePaths = [sharedFM contentsOfDirectoryAtURL:appDataDir includingPropertiesForKeys:properties options:(NSDirectoryEnumerationSkipsHiddenFiles) error:&error];
        
        if (imagePaths == nil)
        {
            NSLog(@"No User Saved Images");
        }
        
    }
    return imagePaths;
}

- (IBAction)deleteButtonAction:(id)sender {
    [self.carousel currentItemView];
}

/*
 
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
