//
//  FLDataModelCategory.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLChallenge.h"

@interface FLDataModelCategory : NSObject

@end

@interface  FLChallenge(FLDataModelCategory)

-(NSString *) dayLeftString;

@end
