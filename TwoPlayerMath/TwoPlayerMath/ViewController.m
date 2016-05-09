//
//  ViewController.m
//  TwoPlayerMath
//
//  Created by Zach Smoroden on 2016-05-09.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"
#import "Player.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic) NSDictionary *currentQuestion;
@property (nonatomic) GameController *gameController;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLabel;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        self.answerTextField.delegate = self;
    
    // Set up the game
    [self setupGame];
    
}


-(void)setupGame {
    
    // Initialize a controller. This will give us 2 players with full lives
    self.gameController = [[GameController alloc] init];
    
    // Get ourselves a new question
    [self getNewQuestion];
    
    // Update the score labels
    [self updateScores];
    
    // Make sure the textfield is empty with just our placeholder text
    self.answerTextField.text = @"";
    self.answerTextField.placeholder = @"Enter your answer...";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Whenever the user presses enter on the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // Get rid of the keyboard
    [self.answerTextField resignFirstResponder];
    
    // Check if the answer is correct
    if([textField.text integerValue] != [self.currentQuestion[@"answer"] integerValue]) {
        // If not correct deduct a life
        [self.gameController.currentPlayer lostLife];
        
        // Answer animation
        [self animateAnswerWithCorrect:NO];
    } else {
        // Answer animation
        [self animateAnswerWithCorrect:YES];
    }
    
    // Refresh the score labels
    [self updateScores];
    
    // CHeck to see if the player lost
    [self checkPlayerLost];
    
    
    return YES;
}

-(void)checkPlayerLost {
    if (self.gameController.currentPlayer.didLose){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Player %ld lost!", self.gameController.currentPlayer.number] message:@"Thanks for playing." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *newGameAction = [UIAlertAction actionWithTitle:@"Play Again" style:UIAlertActionStyleCancel handler:^ (UIAlertAction *action){
            [self setupGame];
        }];
        
        [alert addAction:newGameAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self.gameController nextPlayer];
        self.answerTextField.text = @"";
        
    }

}


-(void)getNewQuestion {
    
    // Get a new question
    self.currentQuestion = [self.gameController getNewQuestion];
    
    // Update the question label
    self.questionLabel.text = [NSString stringWithFormat:@"Player %ld what is %@ %@ %@", (long)self.gameController.currentPlayer.number, self.currentQuestion[@"input"], self.currentQuestion[@"operator"], self.currentQuestion[@"operand"]];
}

// Updates the score labels
-(void)updateScores {
    self.player1ScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.gameController.player1.lives];
    self.player2ScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.gameController.player2.lives];
}

// Just gets rid of the keyboard
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.answerTextField resignFirstResponder];
}

// Sets up the animations of the question label differently depending on if it was correct or not
-(void)animateAnswerWithCorrect:(BOOL)isCorrect {
    self.questionLabel.alpha = 0;
    if (isCorrect) {
        self.questionLabel.text = @"Correct!";
        self.questionLabel.textColor = [UIColor greenColor];
        
    } else {
        self.questionLabel.text = @"Wrong!";
        self.questionLabel.textColor = [UIColor redColor];

    }
    
    [self animateLabel];
}

// Animated the label
-(void)animateLabel{
    [UIView animateWithDuration:1 animations:^{
        self.questionLabel.alpha = 1;
    }
    completion:^(BOOL finished){
        [UIView animateWithDuration:1 animations:^{
            self.questionLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [self getNewQuestion];
            self.questionLabel.alpha = 1;
            self.questionLabel.textColor = [UIColor blackColor];
            
        }];
    }];

}



@end
