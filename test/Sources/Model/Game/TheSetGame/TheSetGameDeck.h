//
//  TheSetGameDeck.h
//  test
//
//  Created by Александр Попов on 10.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheSetGameDeck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;
-(Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
