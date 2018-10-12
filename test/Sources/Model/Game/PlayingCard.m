#import "PlayingCard.h"
#import "TheSetPlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards atGameMode:(BOOL)gameMode
{
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

-(int)match:(NSArray *)otherCards
{
    int score = 0;
        if ([otherCards count] == 1) {
            PlayingCard *otherCard = [otherCards firstObject];
            if ([self.suit isEqualToString:otherCard.suit]) {
                score = 1;
            } else if (self.rank == otherCard.rank) {
                score = 4;
            }
        }
    return score;
}

-(int)checkingTheSet:(NSMutableArray *)cards
{
    int score = 0;
    BOOL theSet = NO;
    int par1 = 0, par2 = 0, par3 = 0;
    
    TheSetPlayingCard *card = [cards firstObject];
    
        for (TheSetPlayingCard *card2 in cards)
        {
            if (card.colorOfObjectsOnTheCard == card2.colorOfObjectsOnTheCard) {
                par1++;
            }
            if (card.countOfObjectsOnTheCard == card2.countOfObjectsOnTheCard) {
                par2++;
            }
            if (card.typeOfCard == card2.typeOfCard) {
                par3++;
            }
        }
    
    if (par1==par2==par3) {
        theSet = YES;
    } else
        if (((par1!=par2) && (par1!=par3)) && (par2 != par3))
    {
        theSet = YES;
    } else if (((par1==par2) && (par1 == par3)) && (par2 == par3)) {
        theSet = YES;
    } else
    {
        theSet = NO;
    }
    if (theSet) score = 10;
    
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
