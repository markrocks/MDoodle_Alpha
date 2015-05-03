//
//  NibButton.m
//  MonsterDoodle
//
//  Created by Mark Martin on 4/14/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "NibButton.h"

@implementation NibButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect myRect = CGRectMake(rect.origin.x+30, rect.origin.y+30, rect.size.width-60 , rect.size.height-60);
    CGContextAddEllipseInRect(ctx, myRect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(ctx);
}

@end
