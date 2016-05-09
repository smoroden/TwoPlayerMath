//
//  Player.m
//  TwoPlayerMath
//
//  Created by Zach Smoroden on 2016-05-09.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)initWithNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        _number = number;
        _lives = 3;
    }
    return self;
}

-(void)lostLife {
    self.lives--;
}

-(BOOL)didLose {
    if (self.lives == 0) {
        return YES;
    }
    
    return NO;
}

@end
