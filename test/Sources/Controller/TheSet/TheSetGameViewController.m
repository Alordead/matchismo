#import "TheSetGameViewController.h"
#import "TheSetPlayingCardDeck.h"

@interface TheSetGameViewController ()

@end

@implementation TheSetGameViewController

- (TheSetPlayingCardDeck *)createDeck
{
    return  [[TheSetPlayingCardDeck alloc] init];
}

@end
