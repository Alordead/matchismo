//
//  CardMatchingGame.h
//  test
//
//  Created by Александр Попов on 05.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index atGameMode:(BOOL)gameMode;
-(Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchingResult;
@property (strong, nonatomic) NSString *matchingCardString;
@property (strong, nonatomic) NSMutableArray *matchingCardsArray;


@end

NS_ASSUME_NONNULL_END
