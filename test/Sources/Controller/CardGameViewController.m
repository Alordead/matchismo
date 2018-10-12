#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "TheSetHistoryViewController.h"

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
@property (strong, nonatomic) NSMutableArray *historyArray;

@end

@implementation CardGameViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[TheSetHistoryViewController class]]) {
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

-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    _gameMode = YES;
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
    int cardIndex = (int)[self.cardButtons indexOfObject:sender];
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
        int cardIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
         cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    NSString *gamestring = self.game.matchingCardString;
    self.lastOperationLabel.attributedText =  [[NSAttributedString alloc] initWithString:gamestring];
    
    if (self.lastOperationLabel.attributedText != self.historyArray.lastObject) {
        [self.historyArray addObject:self.lastOperationLabel.attributedText];
    }
    
}
         
-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
         
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

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
    [self.historyArray removeAllObjects];
    [self restartTheGame];
}

@end
