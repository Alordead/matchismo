//
//  TheSetCardMatchingGame.m
//  test
//
//  Created by Александр Попов on 10.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

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
        _matchingCardString = [NSString stringWithFormat:@""];
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
    
    [self.matchingCardsArray addObject:[card contents]];
    int choosenCardsCount = 1;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.matchingCardsArray removeLastObject];
        } else {
            
            for (TheSetPlayingCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    //int matchScore = [card match:@[otherCard]];
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
            
            int score = [card checkingTheSet:somecards];
            if (score != 0) {
                for (Card *someCard in self.cards) {
                    if (someCard.isChosen && !someCard.isMatched) {
                        
                        someCard.chosen = YES;
                        someCard.matched = YES;
                        
                    }
                }
                self.score += score;
                
                
               // NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:[[somecards objectAtIndex:1] contents] attributes:@{ NSForegroundColorAttributeName: [[somecards objectAtIndex:1] getColor]}];
              //  NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:[somecards objectAtIndex:2] attributes:@{ NSForegroundColorAttributeName: [[somecards objectAtIndex:2] getColor]}];
              // NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:[somecards objectAtIndex:3] attributes:@{ NSForegroundColorAttributeName: [[somecards objectAtIndex:3] getColor]}];
            
                
                self.matchingCardString = [NSMutableString stringWithFormat:@"%@, %@ and %@ is matching! 10 points added", (NSMutableString*)[[somecards objectAtIndex:0] contents], (NSMutableString*)[[somecards objectAtIndex:1] contents],(NSMutableString*)[[somecards objectAtIndex:2] contents]];
                
            } else {
                for (Card *someCard in self.cards) {
                    if (someCard.isChosen && !someCard.isMatched) {
                        someCard.chosen = NO;
                        someCard.matched = NO;
                    }
            }
                self.score -=10;
                
                  self.matchingCardString = [NSMutableString stringWithFormat:@"%@, %@ and %@ is not matching! 10 points removed", (NSMutableString*)[[somecards objectAtIndex:0] contents], (NSMutableString*)[[somecards objectAtIndex:1] contents],(NSMutableString*)[[somecards objectAtIndex:2] contents]];
                
            }
            [self.matchingCardsArray removeAllObjects];
            
        }
    }
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
