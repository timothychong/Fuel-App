//
//  FLDataModelCategory.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLDataModelCategory.h"
#import "FLChallenge.h"


@implementation FLDataModelCategory

@end

@implementation FLChallenge (FLDataModelCategory)

- (NSString *)dayLeftString
{
    NSDate * endDate = self.endDate;
    
    NSTimeInterval interval = [endDate timeIntervalSinceNow];
    
    if (interval > 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%d days left", (int) (interval / 60 / 60 / 24)];
    }else if (interval > 60 * 60){
        return [NSString stringWithFormat:@"%d hours left", (int) (interval / 60 / 60)];
    }else
        return [NSString stringWithFormat:@"%d minutes left", (int) (interval / 60)];
}


-(NSDate *)endDate
{
    return [self.startDate dateByAddingSecond:self.duration.intValue];
}

@end