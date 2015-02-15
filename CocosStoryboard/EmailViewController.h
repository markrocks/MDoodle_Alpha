//
//  EmailViewController.h
//  MonsterDoodle
//
//  Created by Mark Martin on 2/4/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "ImageLoaderCarouselViewController.h"
#import <MessageUI/MessageUI.h>

@interface EmailViewController : ImageLoaderCarouselViewController 

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UITextField *toField;
- (IBAction)sendButtonAction:(id)sender;

@end
