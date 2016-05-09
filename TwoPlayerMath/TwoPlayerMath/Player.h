//
//  Player.h
//  TwoPlayerMath
//
//  Created by Zach Smoroden on 2016-05-09.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger number;

- (instancetype)initWithNumber:(NSInteger)number;

-(void)lostLife;

-(BOOL)didLose;

@end
