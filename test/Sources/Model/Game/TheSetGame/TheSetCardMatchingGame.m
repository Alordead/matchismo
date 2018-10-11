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
        _matchingCardString = [NSMutableString stringWithFormat:@""];
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

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

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
            int i = 0;
            for (TheSetPlayingCard *someCard in self.cards) {
                if (someCard.isChosen && !someCard.isMatched) {
                    //someCard.chosen = YES;
                    //someCard.matched = YES;
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
            } else {
                for (Card *someCard in self.cards) {
                    if (someCard.isChosen && !someCard.isMatched) {
                        someCard.chosen = NO;
                        someCard.matched = NO;
                    }
            }
                self.score -=10;
            }
            [self.matchingCardsArray removeAllObjects];
        }
    }
}

-(instancetype)init
{
    return nil;
}


@end
