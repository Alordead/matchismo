#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
@property (nonatomic) BOOL gameMode;
-(Deck *)createDeck;

@end

