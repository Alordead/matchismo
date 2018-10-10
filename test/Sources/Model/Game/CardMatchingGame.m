//
//  CardMatchingGame.m
//  test
//
//  Created by Александр Попов on 05.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

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

-(void)chooseCardAtIndex:(NSUInteger)index atGameMode:(BOOL)gameMode
{
    if (gameMode) {
        Card *card = [self cardAtIndex:index];
        self.matchingCardString = [NSMutableString stringWithFormat:@""];
        [self.matchingCardsArray insertObject:[card contents] atIndex:0];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.matchingCardsArray removeAllObjects];
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard] atGameMode:gameMode];
                    if (matchScore) {
                        [self.matchingCardsArray insertObject:[otherCard contents] atIndex:1];
                        self.score += matchScore * MATCH_BONUS;
                        self.matchingResult = matchScore * MATCH_BONUS;
                        card.matched = YES;
                        self.matchingCardString = [NSMutableString stringWithFormat:@"%@ and %@ is matching! %ld points added",(NSMutableString*)[self.matchingCardsArray objectAtIndex:0], (NSMutableString*)[self.matchingCardsArray objectAtIndex:1], (long)self.matchingResult];
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        self.matchingResult = MISMATCH_PENALTY;
                        self.matchingCardString = [NSMutableString stringWithFormat:@"%@ and %@ is NOT matching! %ld points removed",(NSMutableString*)[self.matchingCardsArray objectAtIndex:0], (NSMutableString*)[self.matchingCardsArray objectAtIndex:1], (long)self.matchingResult];
                        otherCard.chosen = NO;
                        [self.matchingCardsArray removeLastObject];
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    } else {
        Card *card = [self cardAtIndex:index];
        self.matchingCardString = [NSMutableString stringWithFormat:@""];
        [self.matchingCardsArray addObject:[card contents]];
        int choosenCardsCount = 1;
            if (!card.isMatched) {
                if (card.isChosen) {
                    card.chosen = NO;
                    [self.matchingCardsArray removeLastObject];
                } else {
                    
                    NSMutableArray *arrayOfMatchingCards = [NSMutableArray new];
                    
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            
                            int matchScore = [card match:@[otherCard] atGameMode:gameMode];
                            [self.matchingCardsArray addObject:[otherCard contents]];
                            
                            if (matchScore) {
                                [arrayOfMatchingCards addObject:otherCard];
                                choosenCardsCount++;
                                
                                if ([arrayOfMatchingCards count] == 3) {
                                    matchScore = [[arrayOfMatchingCards objectAtIndex:1] match:@[[arrayOfMatchingCards objectAtIndex:2]] atGameMode:gameMode];
                                    if (!matchScore) {
                                        self.score -= MISMATCH_PENALTY*2;
                                        self.matchingResult = MISMATCH_PENALTY*2;
                                        self.matchingCardString = [NSMutableString stringWithFormat:@"%@ and %@ is NOT matching! %ld points removed",(NSMutableString*)[self.matchingCardsArray objectAtIndex:0], (NSMutableString*)[self.matchingCardsArray objectAtIndex:1], (long)self.matchingResult];
                                        [self.matchingCardsArray removeAllObjects];
                                        [self.matchingCardsArray addObject:[card contents]];
                                        otherCard.chosen = NO;
                                        card.chosen = YES;
                                    }
                                    break;
                                }
                                
                                self.score += matchScore * MATCH_BONUS;
                                self.matchingResult = matchScore * MATCH_BONUS;
                                //card.matched = YES;
                                //otherCard.matched = YES;
                            } else {
                                if (choosenCardsCount==1) {
                                    self.score -= MISMATCH_PENALTY*2;
                                    self.matchingResult = MISMATCH_PENALTY*2;
                                    self.matchingCardString = [NSMutableString stringWithFormat:@"%@ and %@ is NOT matching! %ld points removed",(NSMutableString*)[self.matchingCardsArray objectAtIndex:0], (NSMutableString*)[self.matchingCardsArray objectAtIndex:1], (long)self.matchingResult];
                                    
                                    
                                }
                                [self.matchingCardsArray removeAllObjects];
                                [self.matchingCardsArray addObject:[card contents]];
                                otherCard.chosen = NO;
                                card.chosen = YES;
                            }
                        }
                    }
                    self.score -= COST_TO_CHOOSE;
                    card.chosen = YES;
                }
                if (choosenCardsCount == 3) {
                    int i = 0;
                    for (Card *someCard in self.cards) {
                        if (someCard.isChosen && !someCard.isMatched) {
                            someCard.chosen = YES;
                            someCard.matched = YES;
                            [self.matchingCardsArray insertObject:[someCard contents] atIndex:i];
                            i++;
                        }
                    }
                    self.matchingCardString = [NSMutableString stringWithFormat:@"%@, %@ and %@ is matching! %ld points added",(NSMutableString*)[self.matchingCardsArray objectAtIndex:0], (NSMutableString*)[self.matchingCardsArray objectAtIndex:1], (NSMutableString*)[self.matchingCardsArray objectAtIndex:2], (long)self.matchingResult];
                    [self.matchingCardsArray removeAllObjects];
                }
            }
        }
        
    }

-(instancetype)init
{
    return nil;
}

@end
