//
//  FLMotivator.h
//  Fuel
//
//  Created by Akshar Bonu on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    FLMotivatorTypeText,
    FLMotivatorTypeImage,
    FLMotivatorTypeVideo
} FLMotivatorType;


@class FLChallenge;

@interface FLMotivator : NSManagedObject

@property (nonatomic, retain) FLChallenge *challenge;


-(FLMotivatorType) type;

@end
