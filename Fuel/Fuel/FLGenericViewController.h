//
//  FLGenericViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FLGenericViewController : UIViewController

@property (nonatomic) NSManagedObjectContext * managedObjectContext;


-(void) presentVideoWithPath:(NSString *) str;
@end

@implementation UINavigationBar (UINavigationBarCategory)
- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor blueColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColor(context, CGColorGetComponents( [color CGColor]));
    CGContextFillRect(context, rect);
}   
@end
