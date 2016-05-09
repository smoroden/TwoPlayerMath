//
//  GameController.m
//  TwoPlayerMath
//
//  Created by Zach Smoroden on 2016-05-09.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "GameController.h"
#import "Player.h"

@interface GameController ()


@property (nonatomic) NSArray *operations;


@end

@implementation GameController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _player1 = [[Player alloc] initWithNumber:0];
        _player2 = [[Player alloc] initWithNumber:1];
        _operations = @[@"+", @"-", @"/", @"*"];
        _currentPlayer = _player1;
    }
    return self;
}

-(NSDictionary*)getNewQuestion {
    NSMutableDictionary *newQuestion = [@{} mutableCopy];
    
    NSNumber *input = [NSNumber numberWithInteger:arc4random_uniform(19) + 1];
    NSNumber *operand = [NSNumber numberWithInteger:arc4random_uniform(19) + 1];
    NSString *operator = self.operations[arc4random_uniform((int)self.operations.count)];
    NSNumber *answer;
    
    if ([operator isEqualToString:@"+"]) {
        answer = [NSNumber numberWithInteger:([input integerValue] + [operand integerValue])];
    } else if ([operator isEqualToString:@"-"]) {
        answer = [NSNumber numberWithInteger:([input integerValue] - [operand integerValue])];
    } else if ([operator isEqualToString:@"/"]) {
        answer = [NSNumber numberWithInteger:([input integerValue] / [operand integerValue])];
    } else if ([operator isEqualToString:@"*"]) {
        answer = [NSNumber numberWithInteger:([input integerValue] * [operand integerValue])];
    }

    [newQuestion setValue:input forKey:@"input"];
    [newQuestion setValue:operand forKey:@"operand"];
    [newQuestion setValue:operator forKey:@"operator"];
    [newQuestion setValue:answer forKey:@"answer"];
    
    return newQuestion;
}

-(void)nextPlayer {
    self.currentPlayer = self.currentPlayer == self.player1 ? self.player2 : self.player1;
}


@end
