//
//  FLChallengeCell.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LDProgressView/LDProgressView.h>

@interface FLChallengeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLeftLabel;
@property (weak, nonatomic) IBOutlet LDProgressView *progressView;

@end
