//
//  Recipe.h
//  uitableview example
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Timothy Chong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject{
    NSString *name;
    NSString *detail;
    NSString *imageFile;
}

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *imageFile;

@end
