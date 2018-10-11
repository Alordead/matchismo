//
//  TheSetCardMatchingGame.h
//  test
//
//  Created by Александр Попов on 10.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

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
@property (strong, nonatomic) NSMutableString *matchingCardString;
@property (strong, nonatomic) NSMutableArray *matchingCardsArray;


@end

NS_ASSUME_NONNULL_END
