//
//  CollectionViewCell.h
//  MonsterDoodle
//
//  Created by Mark Martin on 2/27/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *imageName;
@property (strong, nonatomic) IBOutlet UILabel *testlabel;
@end
