//
//  PlayingCardGameViewController.m
//  test
//
//  Created by Александр Попов on 08.10.2018.
//  Copyright © 2018 Александр Попов. All rights reserved.
//

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
