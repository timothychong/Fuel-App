//
//  FLChallenge.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLChallengeUpdate, FLMotivator;

@interface FLChallenge : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSSet *updates;
@property (nonatomic, retain) NSSet *motivators;
@end

@interface FLChallenge (CoreDataGeneratedAccessors)

- (void)addUpdatesObject:(FLChallengeUpdate *)value;
- (void)removeUpdatesObject:(FLChallengeUpdate *)value;
- (void)addUpdates:(NSSet *)values;
- (void)removeUpdates:(NSSet *)values;

- (void)addMotivatorsObject:(FLMotivator *)value;
- (void)removeMotivatorsObject:(FLMotivator *)value;
- (void)addMotivators:(NSSet *)values;
- (void)removeMotivators:(NSSet *)values;

@end
