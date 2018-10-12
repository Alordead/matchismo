#import "Deck.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TheSetCardGameViewController : UIViewController

@property (nonatomic) BOOL gameMode;

-(Deck *)createDeck;

@end

NS_ASSUME_NONNULL_END
