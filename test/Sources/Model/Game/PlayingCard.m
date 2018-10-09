//
//  PlayingCard.m
//  test
//
//  Created by Александр Попов on 04.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards atGameMode:(BOOL)gameMode
{
    if (nil == gameMode) { gameMode = YES;}
    int score = 0;
    if (gameMode == YES) { // 2 out 2 gamemode
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        } else if (self.rank == otherCard.rank) {
            score = 4;
        }
    }
    } else if (gameMode == NO) { // 3 out 3 gamemode
        if ([otherCards count] == 2) {
            PlayingCard *otherCard = [otherCards firstObject];
            PlayingCard *otherCard2 = [otherCards objectAtIndex:1];
            if ([self.suit isEqualToString:otherCard.suit] && [self.suit isEqualToString:otherCard2.suit]) {
                score = 1;
            } else if (self.rank == otherCard.rank && self.rank == otherCard2.rank) {
                score = 4;
            }
        }
    }
    return score;
}

@synthesize suit = _suit;
+(NSArray *)validSuits
{
    return @[@"♦",@"♣",@"♥",@"♠"];
}
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSUInteger)maxRank { return [[self rankStrings] count]-1; }

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
