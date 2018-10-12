#import "PlayingCard.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheSetCardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(void)giveMeMore;
-(Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchingResult;
@property (strong, nonatomic) NSAttributedString *matchingCardString;
@property (strong, nonatomic) NSMutableArray *matchingCardsArray;


@end

NS_ASSUME_NONNULL_END
