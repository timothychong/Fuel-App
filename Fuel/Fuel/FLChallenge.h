//
//  FLChallenge.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FLChallenge : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSSet *updates;
@property (nonatomic, retain) NSSet *motivators;
@end

@interface FLChallenge (CoreDataGeneratedAccessors)

- (void)addUpdatesObject:(NSManagedObject *)value;
- (void)removeUpdatesObject:(NSManagedObject *)value;
- (void)addUpdates:(NSSet *)values;
- (void)removeUpdates:(NSSet *)values;

- (void)addMotivatorsObject:(NSManagedObject *)value;
- (void)removeMotivatorsObject:(NSManagedObject *)value;
- (void)addMotivators:(NSSet *)values;
- (void)removeMotivators:(NSSet *)values;

@end
