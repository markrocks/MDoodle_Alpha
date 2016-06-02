//
//  ImageLoaderCarouselViewController.h
//  MonsterDoodle
//
//  Created by Mark Martin on 1/20/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "iCarousel.h"

@interface ImageLoaderCarouselViewController : UIViewController <iCarouselDataSource>

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
- (IBAction)homeButtonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)removeImgAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *imagesWithDeleteRefs;

@end
