//
//  GameController.h
//  TwoPlayerMath
//
//  Created by Zach Smoroden on 2016-05-09.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface GameController : NSObject

@property (nonatomic) Player *currentPlayer;
@property (nonatomic, readonly) Player *player1;
@property (nonatomic, readonly) Player *player2;

-(NSDictionary*)getNewQuestion;
-(void)nextPlayer;

@end
