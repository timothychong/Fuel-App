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
    NSTimeInterval interval = [self.endDate timeIntervalSinceDate:self.startDate];

    return [NSString stringWithFormat:@"%d days left", (int) (interval / 60 / 60 / 24)];
}


-(CGFloat)percentFinished
{
    NSTimeInterval entireInterval = [self.endDate timeIntervalSinceDate:self.startDate];
    NSTimeInterval partialInterval = [[NSDate new] timeIntervalSinceDate: self.startDate];
    
    return partialInterval / entireInterval;
}

@end

@implementation FLMotivator (FLDataModelCategory)

-(NSString *)dateAddedString
{
    if (self.dateAdded) {
        NSDateFormatter * formatter =  [NSDateFormatter new];
        formatter.dateFormat = @"MMM d, yyyy";
        return [NSString stringWithFormat:@"Date Added: %@",[formatter stringFromDate:self.dateAdded]];
    }else
        return @"Unknown Date Added";
}
-(FLMotivatorType)type
{
    [NSException raise:@"FLMotivator Error" format:@"Undetermined type"];
    return FLMotivatorTypeText;
}

@end


@implementation FLMotivatorText (FLDataModelCategory)

-(FLMotivatorType)type
{
    return FLMotivatorTypeText;
}

@end

@implementation FLMotivatorImage (FLDataModelCategory)

-(FLMotivatorType)type
{
    return FLMotivatorTypeImage;
}

@end

@implementation FLMotivatorVideo (FLDataModelCategory)

-(FLMotivatorType)type
{
    return FLMotivatorTypeVideo;
}

@end
