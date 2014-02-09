//
//  FLChallenge.h
//  Fuel
//
//  Created by Akshar Bonu on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FLChallengeUpdate, FLMotivator;

@interface FLChallenge : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *motivators;
@property (nonatomic, retain) NSSet *updates;
@end

@interface FLChallenge (CoreDataGeneratedAccessors)

- (void)addMotivatorsObject:(FLMotivator *)value;
- (void)removeMotivatorsObject:(FLMotivator *)value;
- (void)addMotivators:(NSSet *)values;
- (void)removeMotivators:(NSSet *)values;

- (void)addUpdatesObject:(FLChallengeUpdate *)value;
- (void)removeUpdatesObject:(FLChallengeUpdate *)value;
- (void)addUpdates:(NSSet *)values;
- (void)removeUpdates:(NSSet *)values;

@end
