//
//  FLMotivator.h
//  Fuel
//
//  Created by Timothy Chong on 2/9/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLChallenge;

@interface FLMotivator : NSManagedObject

@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) FLChallenge *challenge;

@end
