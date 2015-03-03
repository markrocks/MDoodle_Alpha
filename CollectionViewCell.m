//
//  CollectionViewCell.m
//  MonsterDoodle
//
//  Created by Mark Martin on 2/27/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
/*
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CMFGalleryCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}
 */

-(void)updateCell {
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets"];
    NSString *filename = [NSString stringWithFormat:@"%@/%@", sourcePath, self.imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filename];
    
    //[self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    //[self.imageView setImage:image];
}
@end
