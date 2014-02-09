//
//  FLDataModelCategory.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLChallenge.h"
#import "FLMotivator.h"
#import "FLMotivatorText.h"
#import "FLMotivatorImage.h"
#import "FLMotivatorVideo.h"

typedef enum {
    FLMotivatorTypeText,
    FLMotivatorTypeImage,
    FLMotivatorTypeVideo
}FLMotivatorType;

@interface FLDataModelCategory : NSObject

@end

@interface  FLChallenge(FLDataModelCategory)

-(NSString *) dayLeftString;
-(CGFloat) percentFinished;

@end

@interface FLMotivator (FLDataModelCategory)

-(NSString *) dateAddedString;
-(FLMotivatorType) type;

@end
