//
//  FLChallengeUpdate.h
//  Fuel
//
//  Created by Akshar Bonu on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLChallenge;

@interface FLChallengeUpdate : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) FLChallenge *challenge;

@end
