 //
//  ViewController.m
//  test
//
//  Created by Александр Попов on 04.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Deck* someProperty;
@property (weak, nonatomic) IBOutlet UIButton *restartTheGameButton;
@property (weak, nonatomic) IBOutlet UISwitch *switchTheGameModeButton;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningNeedToRestartLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastOperationLabel;

@end

@implementation CardGameViewController

//-(Deck *)someProperty
//{
////    if (!_someProperty) _someProperty = [[Deck alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
////    return _someProperty;
//}

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}
-(CardMatchingGame *)restartTheGame
{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    if ([self.gameModeLabel.text isEqualToString: @"3 out 3 mode"]) {
        _gameMode = NO;
    } else {_gameMode = YES; }
    
    [_switchTheGameModeButton setEnabled:YES];
    [self.warningNeedToRestartLabel setHidden:YES];
    //self.lastOperationLabel = [NSString stringWithFormat:@""];
    return _game;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    if (_gameMode) {
        [self.game chooseCardAtIndex:cardIndex atGameMode:_gameMode];
    } else {
        [self.game chooseCardAtIndex:cardIndex atGameMode:_gameMode];
    }
    
    [_switchTheGameModeButton setEnabled:NO];
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
         cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.lastOperationLabel.text = [NSString stringWithFormat:@"%@", self.game.matchingCardString];
}
         
-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
         
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

// Homework 2

- (IBAction)actionOnChangedSwitch:(id)sender
{
    if (self.switchTheGameModeButton.isOn)
    {
    self.gameModeLabel.text=[NSString stringWithFormat:@"2 out 2 mode"];
    } else {
    self.gameModeLabel.text=[NSString stringWithFormat:@"3 out 3 mode"];
    }
    [self.warningNeedToRestartLabel setHidden:NO];
}
- (IBAction)restartTheGameAction:(id)sender
{
    
    [self restartTheGame];
}


@end
