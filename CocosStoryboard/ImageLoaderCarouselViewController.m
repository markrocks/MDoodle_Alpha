//
//  ImageLoaderCarouselViewController.m
//  MonsterDoodle
//
//  Created by Mark Martin on 1/20/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "ImageLoaderCarouselViewController.h"

@interface ImageLoaderCarouselViewController ()
@end

@interface ImgWithDeleteRef : NSObject
{
    NSString *path;
    UIImage *image;
}
@property NSString *path;
@property UIImage *image;
@end
@implementation ImgWithDeleteRef
@end





@implementation ImageLoaderCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[carousel
    
    //configure carousel
    _carousel.type = iCarouselTypeRotary;
    //_carousel.iCarouselOptionCount = 10;
   // _carousel.iCarouselOptionVisibleItems = 10;
    //_carousel.type = iCarouselTypeTimeMachine;
    //_carousel.perspective = -0.0025;
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"nibNam = %@  nibBundle %@", nibNameOrNil,nibBundleOrNil );
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        //get image paths
        NSArray *imagePaths = [self getImagePaths];
        
        //preload images (although FXImageView can actually do this for us on the fly)
        _images = [[NSMutableArray alloc] init];
        _imagesWithDeleteRefs = [[NSMutableArray alloc] init];
        UIImage *monsterImage;
        for (NSObject *path in imagePaths)
        {
            if([path isKindOfClass:[NSString class]])
            {
                monsterImage = [UIImage imageWithContentsOfFile:(NSString *)path];
                if((monsterImage == nil)==NO)
                {
                    [_images addObject:monsterImage];
                    ImgWithDeleteRef *mObj = [ImgWithDeleteRef new];
                    [mObj setPath:path];
                    [mObj setImage:monsterImage];
                    [_imagesWithDeleteRefs addObject:mObj];
                }
            }
            
            if([path isKindOfClass:[NSURL class]])
            {
                NSString *pathString = [(NSURL *) path path];
                monsterImage = [UIImage imageWithContentsOfFile:pathString];
                if((monsterImage == nil)==NO)
                {
                    [_images addObject:monsterImage];
                    ImgWithDeleteRef *mObj = [ImgWithDeleteRef new];
                    [mObj setPath:pathString];
                    [mObj setImage:monsterImage];
                    [_imagesWithDeleteRefs addObject:mObj];
                    
                }
            }
            
        }
    }
    return self;
}


/**
 This method calculated the location of the images for the carousel. This method is meant to be overriden by sub classes --
 **/

-(NSArray *) getImagePaths {
    return [[NSArray alloc]init];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_images count];
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
    [self.counterLabel setText:[NSString stringWithFormat: @"%ld/%ld", (long)[self.carousel currentItemIndex]+1, (long)[self.carousel numberOfItems]]] ;   }

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.width/2.2, screenRect.size.height/2.2);

        FXImageView *imageView = [[FXImageView alloc] initWithFrame:self.view.frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;
        [self.counterLabel setText:[NSString stringWithFormat: @"%ld/%ld", (long)[self.carousel currentItemIndex]+1, (long)[self.carousel numberOfItems]]] ;  
 
    }
    
    
    //show placeholder
    ((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];
    
    //set image
    ((FXImageView *)view).image = _images[index];
    
    return view;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark iCarousel taps



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

- (IBAction)homeButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMenuScreen" object:self];
}



- (IBAction)deleteButtonAction:(id)sender{
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"loadMenuScreen" object:self];

}




- (IBAction)removeImgAction:(id)sender {
    NSError *error = nil;
    FXImageView *myView = [self.carousel currentItemView];
        for (ImgWithDeleteRef *img in self.imagesWithDeleteRefs)
        {
            if ([myView image]== [img image]){
                NSLog(@"img path found is = %@  ", [img path] );
                [[NSFileManager defaultManager] removeItemAtPath:[img path]  error:&error];
                [self.carousel removeItemAtIndex:[self.carousel indexOfItemView:myView] animated:YES];
            }
        }
}
@end
