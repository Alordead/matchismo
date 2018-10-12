#import "TheSetCardMatchingGame.h"
#import "TheSetPlayingCard.h"

@interface TheSetCardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation TheSetCardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
        _matchingCardString = [[NSAttributedString alloc] initWithString:@""];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.matchingCardsArray = [NSMutableArray new];
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    TheSetPlayingCard *card = [self cardAtIndex:index];
    [self.matchingCardString initWithString:@""];
    [self.matchingCardsArray addObject:[card contents]];
    int choosenCardsCount = 1;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.matchingCardsArray removeLastObject];
        } else {
            
            for (TheSetPlayingCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.matchingCardsArray addObject:[otherCard contents]];
                    choosenCardsCount++;
                }
            }
            card.chosen = YES;
        }
        NSMutableArray *somecards = [[NSMutableArray alloc] init];
        if (choosenCardsCount == 3) {
            NSInteger i = 0;
            for (TheSetPlayingCard *someCard in self.cards) {
                if (someCard.isChosen && !someCard.isMatched) {
                    [self.matchingCardsArray insertObject:[someCard contents] atIndex:i];
                    [somecards insertObject:someCard atIndex:i];
                    i++;
                }
            }
            
            TheSetPlayingCard *card1 = [somecards objectAtIndex:0];
            TheSetPlayingCard *card2 = [somecards objectAtIndex:1];
            TheSetPlayingCard *card3 = [somecards objectAtIndex:2];
            
            int score = [card checkingTheSet:somecards];
            if (score != 0) {
                for (Card *someCard in self.cards) {
                    if (someCard.isChosen && !someCard.isMatched) {
                        
                        someCard.chosen = YES;
                        someCard.matched = YES;
                    }
                }
                self.score += score;

                
//                NSAttributedString *card1astr = [[NSAttributedString alloc] initWithString:card1.contents attributes:@{ NSForegroundColorAttributeName: card1.getColor }];
//                NSAttributedString *card2astr = [[NSAttributedString alloc] initWithString:card2.contents attributes:@{ NSForegroundColorAttributeName: card2.getColor }];
//                NSAttributedString *card3astr = [[NSAttributedString alloc] initWithString:card3.contents attributes:@{ NSForegroundColorAttributeName: card3.getColor }];
//
//                NSMutableAttributedString *astr = [NSMutableAttributedString new];
//                [astr appendAttributedString:card1astr];
//                [astr appendAttributedString:card2astr];
//                [astr appendAttributedString:card3astr];

                NSString *line = @"%card1%, %card2% and %card3% is matching! 10 points added";
                NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:line];
                [self colorCard:card1 insideLine:astr withFormat:@"%card1%"];
                [self colorCard:card2 insideLine:astr withFormat:@"%card2%"];
                [self colorCard:card3 insideLine:astr withFormat:@"%card3%"];
                
                self.matchingCardString = astr.copy;
                
            } else {
                for (Card *someCard in self.cards) {
                    if (someCard.isChosen && !someCard.isMatched) {
                        someCard.chosen = NO;
                        someCard.matched = NO;
                    }
            }
                self.score -=10;
                
                
                NSString *line = @"%card1%, %card2% and %card3% is not matching! 10 points removed";
                NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:line];
                [self colorCard:card1 insideLine:astr withFormat:@"%card1%"];
                [self colorCard:card2 insideLine:astr withFormat:@"%card2%"];
                [self colorCard:card3 insideLine:astr withFormat:@"%card3%"];

                self.matchingCardString = astr.copy;
                
            }
            [self.matchingCardsArray removeAllObjects];
            
        }
    }
}


- (void)colorCard:(TheSetPlayingCard *)card insideLine:(NSMutableAttributedString *)attrLine withFormat:(NSString *)format
{
    NSRange r = [attrLine.string rangeOfString:format];
    NSAttributedString *attributedCardString = [[NSAttributedString alloc] initWithString:card.contents attributes:@{ NSForegroundColorAttributeName: card.getColor }];
    
    [attrLine replaceCharactersInRange:r withString:@""];
    [attrLine insertAttributedString:attributedCardString atIndex:r.location];
}

-(void)giveMeMore
{
    NSUInteger index = 0;
    for (TheSetPlayingCard *card in self.cards.copy)
    {
        if (card.isMatched) {
            card.typeOfCard = [TheSetPlayingCard randomType];
            card.countOfObjectsOnTheCard = [TheSetPlayingCard randomCountOfObjects];
            UIColor *c = [UIColor new];
            c =[TheSetPlayingCard randomColor];
            if (!c) { c = [UIColor blackColor]; }
            card.colorOfObjectsOnTheCard = c;
            
            card.chosen = NO;
            card.matched = NO;
            
            self.cards[index] = card;
            
        }
        index++;
    }
}

-(instancetype)init
{
    return nil;
}

@end
