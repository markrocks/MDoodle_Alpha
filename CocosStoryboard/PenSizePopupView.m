//
//  PenSizePopupView.m
//  MonsterDoodle
//
//  Created by Mark Martin on 4/10/15.
//  Copyright (c) 2015 Sias Studios. All rights reserved.
//

#import "PenSizePopupView.h"

@implementation PenSizePopupView

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
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(ctx);
}

@end
