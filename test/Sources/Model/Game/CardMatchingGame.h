#import <Foundation/Foundation.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index atGameMode:(BOOL)gameMode;
-(Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchingResult;
@property (strong, nonatomic) NSMutableString *matchingCardString;
@property (strong, nonatomic) NSMutableArray *matchingCardsArray;


@end

NS_ASSUME_NONNULL_END
