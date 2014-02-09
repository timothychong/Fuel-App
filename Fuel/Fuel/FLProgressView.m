//
//  FLProgressView.m
//  Fuel
//
//  Created by Timothy Chong on 2/9/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLProgressView.h"

@implementation FLProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.type = LDProgressSolid;
    self.progress = 0.4;
    self.background = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    self.color = [UIColor colorWithRed:80/255.0 green:227/255.0 blue:194/255.0 alpha:1];
    self.flat = @YES;
    self.showText = @NO;
    self.showStroke = @NO;
    self.animate = @YES;
    self.showBackground = @YES;
    self.progressInset = @2;
}

- (void)drawProgressBackground:(CGContextRef)context inRect:(CGRect)rect {
    CGContextSaveGState(context);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.borderRadius.floatValue];
    CGContextSetFillColorWithColor(context, self.background.CGColor);
    [roundedRect fill];
    
    UIBezierPath *roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect:CGRectMake(-10, -10, rect.size.width+10, rect.size.height+10)];
    [roundedRectangleNegativePath appendPath:roundedRect];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
//    
//    CGSize shadowOffset = CGSizeMake(0.5, 1);
//    CGContextSaveGState(context);
//    CGFloat xOffset = shadowOffset.width + round(rect.size.width);
//    CGFloat yOffset = shadowOffset.height;
//    CGContextSetShadowWithColor(context,
//                                CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)), 5, [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor);
    
    [roundedRect addClip];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(rect.size.width), 0);
    [roundedRectangleNegativePath applyTransform:transform];
    [[UIColor grayColor] setFill];
    [roundedRectangleNegativePath fill];
    CGContextRestoreGState(context);
    
    // Add clip for drawing progress
    [roundedRect addClip];
}

@end
