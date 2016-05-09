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
    
    [self setupGame];
    
}

-(void)setupGame {
    self.gameController = [[GameController alloc] init];
    
    [self getNewQuestion];
    [self updateScores];
    self.answerTextField.text = @"";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//-(void)textViewDidEndEditing:(UITextView *)textView {
//    [self.answerTextField resignFirstResponder];
//    
//    if([textView.text integerValue] != [self.currentQuestion[@"answer"] integerValue]) {
//        [self.gameController.currentPlayer lostLife];
//    }
//    [self updateScores];
//    [self.gameController nextPlayer];
//    self.answerTextField.text = @"";
//    [self getNewQuestion];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.answerTextField resignFirstResponder];
    
    if([textField.text integerValue] != [self.currentQuestion[@"answer"] integerValue]) {
        [self.gameController.currentPlayer lostLife];
        [self animateAnswerWithCorrect:NO];
    } else {
        [self animateAnswerWithCorrect:YES];
    }
    [self updateScores];
    
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
    
    
    
    return YES;
}


-(void)getNewQuestion {
    self.currentQuestion = [self.gameController getNewQuestion];
    
    self.questionLabel.text = [NSString stringWithFormat:@"Player %ld what is %@ %@ %@", (long)self.gameController.currentPlayer.number, self.currentQuestion[@"input"], self.currentQuestion[@"operator"], self.currentQuestion[@"operand"]];
}

-(void)updateScores {
    self.player1ScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.gameController.player1.lives];
    self.player2ScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.gameController.player2.lives];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.answerTextField resignFirstResponder];
}

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
