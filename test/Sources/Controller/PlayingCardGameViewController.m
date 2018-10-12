#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return  [[PlayingCardDeck alloc] init];
}

@end
