#import "TheSetPlayingCardDeck.h"
#import "TheSetPlayingCard.h"

@implementation TheSetPlayingCardDeck

-(instancetype)init
{
    self = [super init];
    if (self) {
        for (NSInteger x = 0; x<4;x++) {
            for (NSUInteger count = 1; count < 12; count++) {
                TheSetPlayingCard *card = [TheSetPlayingCard new];
                card.typeOfCard = [TheSetPlayingCard randomType];
                card.countOfObjectsOnTheCard = [TheSetPlayingCard randomCountOfObjects];
                UIColor *c = [UIColor new];
                c =[TheSetPlayingCard randomColor];
                if (!c) { c = [UIColor blackColor];}
                card.colorOfObjectsOnTheCard = c ;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
