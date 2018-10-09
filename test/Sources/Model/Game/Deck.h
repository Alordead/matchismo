#import "Card.h"
#import <Foundation/Foundation.h>

#ifndef Deck_h
#define Deck_h




@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;
-(Card *)drawRandomCard;


@end

#endif /* Deck_h */
