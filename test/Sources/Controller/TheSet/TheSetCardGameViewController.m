//
//  TheSetCardGameViewController.m
//  test
//
//  Created by Александр Попов on 10.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "TheSetCardGameViewController.h"
#import "TheSetPlayingCardDeck.h"
#import "TheSetCardMatchingGame.h"
#import "TheSetPlayingCard.h"
#import "TheSetHistoryViewController.h"

@interface TheSetCardGameViewController()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) TheSetCardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UIButton *theSetUIButton;
@property (weak, nonatomic) IBOutlet UIButton *restartUIButton;
@property (weak, nonatomic) IBOutlet UILabel *lastOperationLabel;
@property (strong, nonatomic) NSMutableArray *historyArray;

@end

@implementation TheSetCardGameViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if([segue.destinationViewController isKindOfClass:[TheSetHistoryViewController class]]) {
            TheSetHistoryViewController *tshvc = (TheSetHistoryViewController *)segue.destinationViewController;
            tshvc.historyArray = self.historyArray;
        }
}

-(NSMutableArray *)historyArray
{
    if (!_historyArray)
    {
        _historyArray = [[NSMutableArray alloc] init];
    }
    return _historyArray;
}

-(TheSetCardMatchingGame *)game
{
   if (!_game)
   {
       _game = [[TheSetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
       
   }
   return _game;
}
-(TheSetCardMatchingGame *)restartTheGame
{
    _game = [[TheSetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
   [self updateUI];
    [self.historyArray removeAllObjects];
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = (int)[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = (int)[self.cardButtons indexOfObject:cardButton];
        TheSetPlayingCard *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setTitleColor:[self colorForTint:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    NSMutableString *labelString = [NSMutableString stringWithFormat:@"%@", self.game.matchingCardString];
    
    self.lastOperationLabel.text = labelString;
    if (self.game.matchingCardString != self.historyArray.lastObject) {
    [self.historyArray addObject:self.lastOperationLabel.text];
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ?   @"" : card.contents;
}
         
-(UIColor *)colorForTint:(TheSetPlayingCard *)card
{
    return card.colorOfObjectsOnTheCard;
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardback" : @"cardfront"];
}

- (IBAction)restartTheGameAction:(id)sender
{
    [self restartTheGame];
}

- (IBAction)giveMeMoreButton:(id)sender {
    [self.game giveMeMore];
    [self updateUI];
}






@end
